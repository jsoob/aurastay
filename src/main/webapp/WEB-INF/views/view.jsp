<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
        <!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>리뷰 작성</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="bg-light">
    <div class="container mt-5">
        <div class="card shadow-sm">
            <div class="card-body">
                <h2 class="card-title">리뷰 작성</h2>
                <form action="submitReview" method="post" enctype="multipart/form-data">
                    <div class="mb-3">
                        <label for="reviewText" class="form-label">숙박 후기를 남겨주세요</label>
                        <textarea class="form-control" id="reviewText" name="review" rows="4" required></textarea>
                    </div>
                    <div class="mb-3">
                        <label for="imageUpload" class="form-label">사진 업로드</label>
                        <input class="form-control" type="file" id="imageUpload" name="image" accept="image/*">
                    </div>
                    <div class="text-end">
                        <button type="reset" class="btn btn-outline-danger">취소</button>
                        <button type="submit" class="btn btn-primary">등록</button>
                    </div>
                </form>
            </div>
        </div>
    </div>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
