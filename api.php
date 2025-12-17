<?php
header('Content-Type: application/json; charset=utf-8');

require_once __DIR__ . '/db/config.php';

if ($_SERVER['REQUEST_METHOD'] !== 'POST') {
    echo json_encode(['success' => false, 'error' => 'Only POST requests are allowed']);
    exit;
}

$title = isset($_POST['title']) ? trim($_POST['title']) : '';
if ($title === '') {
    echo json_encode(['success' => false, 'error' => 'Missing movie title']);
    exit;
}

try {
    $pdo = getPDO();
    $sql = "SELECT a.name AS actor_name, r.role_name
            FROM movies m
            JOIN roles r ON m.id = r.movie_id
            JOIN actors a ON r.actor_id = a.id
            WHERE m.title = :title
            ORDER BY r.id";
    $stmt = $pdo->prepare($sql);
    $stmt->execute([':title' => $title]);
    $rows = $stmt->fetchAll(PDO::FETCH_ASSOC);
    echo json_encode(['success' => true, 'data' => $rows]);
} catch (PDOException $e) {
    echo json_encode(['success' => false, 'error' => 'Database error: ' . $e->getMessage()]);
}
