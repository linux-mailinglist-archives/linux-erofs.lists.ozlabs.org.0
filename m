Return-Path: <linux-erofs+bounces-151-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id C671CA7DBDC
	for <lists+linux-erofs@lfdr.de>; Mon,  7 Apr 2025 13:07:00 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4ZWRHP1gbDz2yhb;
	Mon,  7 Apr 2025 21:06:57 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::52f"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1744024017;
	cv=none; b=EH42/fRQ1fbVHp3cvI6CoxBev0U8DHBgtQiIatL2gvBBtv4DJx7tU+lyKScaSlpy84MyQw1rq7rvb5dCI9A/JZEGbW3coQU+GvC1Yy6xJNCyUPo64GvaFDIWBNT0s8mk7FbTxgPglXhobUGeINrhBpho98BQMoCBdNc7hRdLPLXoy41+TUPUjLZZedA3lFEd9gKxNbWvEiD6VkCt12uhJmhjkoh3FEHTsy4NiY9yLLmkGUXgwEa+bUWiYCNwTsrO3YtJL8kWcjJJoNN6nm4ZvJ07h7vK+rlzJFeiiWL6A0MHdmoNyEluSq0ciIEtnoqzQF/28cvDX7mBNoxUsrBr0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1744024017; c=relaxed/relaxed;
	bh=ZOptbtbOKUdHNzNg9ygqhPthLmzyP2uo7jPEq6N+YNQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=KOnxrWO6XD410e4G90KAJSRjPMEGXPTOkJOlSBFm/3bqw4otKgEN6RDSUU/Af1Ia5nRy3FFq6Zd/PadeLuZ5oaJDdO02cPJeIMeJnRIv7nCcy8duu9H16ek/aBLf4JGm02hgFSK5HTZ4s9Pk/i5KFsmiFQo5JhpEwswFYJCqqRNRmnC07WR4JOfuIkg+ai2mPzwiw3trLYMoq6qz3cDMblBHZ1dBaz1ZrLcVc7bbctFbQ8T1tWoVu7F/nCF0mdlJHsEAWcCJXl0dryvTWF7fCwjpLGE1ohe1GHzeJwP/P5rxyjNFYpJ6TzIwam/G9Un3//JGh4/IqDrL/Ao+GvQQlw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=hT1zS5eA; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::52f; helo=mail-pg1-x52f.google.com; envelope-from=shengyong2021@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=hT1zS5eA;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::52f; helo=mail-pg1-x52f.google.com; envelope-from=shengyong2021@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4ZWRHM2qTmz2y92
	for <linux-erofs@lists.ozlabs.org>; Mon,  7 Apr 2025 21:06:54 +1000 (AEST)
Received: by mail-pg1-x52f.google.com with SMTP id 41be03b00d2f7-af51e820336so3842445a12.1
        for <linux-erofs@lists.ozlabs.org>; Mon, 07 Apr 2025 04:06:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744024012; x=1744628812; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ZOptbtbOKUdHNzNg9ygqhPthLmzyP2uo7jPEq6N+YNQ=;
        b=hT1zS5eAAYee2OYWW7kz2CFe0HHMHO3Ks3rMkUZuPU6OHqNS3O/Q4FMWvzTTW2IF0I
         pa9yEu5+iMAhZuWULmwyoPtbHBZXlkMd8jif0y3vNZLylW3oZlLQgYJQbE9VefWXYu5e
         Tl45MElqLkZn5AxV1VDvqD2PN9xNJY5xGKeo1EDAL68NcyYdIt/MglZKuBCGmtkz0hzb
         CxZJ+TbYYfGJM0eFqJ26xuXOAhlp+3u0xF88O426DnKL4rbzgxdvIL6Qj3djlOaEw76T
         IJiccPgfON7gEvqgZMF8qqAvLRVTBx/OnON20IRk+3cb69ziaedsJmgJiXBq5UmKO1e/
         ++xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744024012; x=1744628812;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZOptbtbOKUdHNzNg9ygqhPthLmzyP2uo7jPEq6N+YNQ=;
        b=Vu8MGd/9Dmi6wwyPGWiXAGI6HTGZg9PdvU0ymXlAPh+Q1NnCm/QDaSzr/7ummrxdDk
         tESB3u/Af7hkAb7+yQoK8TEqYh85VIAMgJDfh3ybHiGRkzgUl5QMm2+WmbmkriPaPkSm
         Uhvdf20H6Ptcf0dH5XHN3hBMftzGXqQlhvvSX1YzAy3XyjQnsK6bCLx+2MoAPoH9Vnbt
         6JlGQsZAQtDVjY4y1ffVAA4uSJfSF21QIfy2xrfcMe83DqxWbMLQ5oHC12z5z3EfsnAB
         qlKjErv4/aJT0w8WaWoAaXkIwWBfOfwSu6R9qCOWWNdHAxfdZ5WUqGIxjrQhRlHDZw3o
         xWbw==
X-Gm-Message-State: AOJu0YzykPAMpzRb8xAUo0V8/6zO5aaWxpjoCw0mEpk6rTUp+hVNNjsG
	cT0pPQ1h7po4cHrB4yaiuoVV1Xf1s8535IW4VKcZ5+IZlAl8CHM+
X-Gm-Gg: ASbGncsSn+j3ALV9xwFTqBE9Q5/G3ckCjIHogniE+qEMEbq7lBmPMDkxLr6jLXYu82Q
	wpEznwY1s9i2k4Y31rZG9tjF+iZK6GNbenMuY4CPac0zlLqLo/8oQY51TJccHq7j3OmgueoyZc3
	VfwfYhPUHHTCQwVXQGjEJc8etUl5nUiD06cmrEpiMU2WoUpTmjzllMEU500mtFqG1fPm3IquE29
	wYkZ/FnYdqoJUZpCmhNzYHuHRvuips/tBMm9JglEQFD/0r3QwzIXuOPLKbEJMHy3KF/UhD57Dbh
	ZEGqLOTdXOULaoBf8k9lf1gdEOtWHdG82akTag9o7wuMVDGGVspwbIDycPxNpQ==
X-Google-Smtp-Source: AGHT+IEER9gMFbZAIOso3TAQGWYEqTKd27YcUoJoECCDkKgwZqvn74/cLLH1AbzkTcSTwTfsj0FPkg==
X-Received: by 2002:a17:90b:2d0d:b0:2fe:b735:87da with SMTP id 98e67ed59e1d1-306af5f1de3mr14855986a91.0.1744024012042;
        Mon, 07 Apr 2025 04:06:52 -0700 (PDT)
Received: from PC.mioffice.cn ([43.224.245.227])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3057cb5d672sm8783946a91.31.2025.04.07.04.06.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Apr 2025 04:06:51 -0700 (PDT)
From: Sheng Yong <shengyong2021@gmail.com>
X-Google-Original-From: Sheng Yong <shengyong1@xiaomi.com>
To: xiang@kernel.org,
	hsiangkao@linux.alibaba.com,
	chao@kernel.org,
	zbestahu@gmail.com,
	jefflexu@linux.alibaba.com,
	dhavale@google.com
Cc: linux-erofs@lists.ozlabs.org,
	linux-kernel@vger.kernel.org,
	Sheng Yong <shengyong1@xiaomi.com>
Subject: [PATCH v3 1/2] erofs: set error to bio if file-backed IO fails
Date: Mon,  7 Apr 2025 19:05:50 +0800
Message-ID: <20250407110551.1538457-1-shengyong1@xiaomi.com>
X-Mailer: git-send-email 2.43.0
X-Mailing-List: linux-erofs@lists.ozlabs.org
List-Id: <linux-erofs.lists.ozlabs.org>
List-Help: <mailto:linux-erofs+help@lists.ozlabs.org>
List-Owner: <mailto:linux-erofs+owner@lists.ozlabs.org>
List-Post: <mailto:linux-erofs@lists.ozlabs.org>
List-Subscribe: <mailto:linux-erofs+subscribe@lists.ozlabs.org>,
  <mailto:linux-erofs+subscribe-digest@lists.ozlabs.org>,
  <mailto:linux-erofs+subscribe-nomail@lists.ozlabs.org>
List-Unsubscribe: <mailto:linux-erofs+unsubscribe@lists.ozlabs.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=disabled
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org

From: Sheng Yong <shengyong1@xiaomi.com>

If a file-backed IO fails before submitting the bio to the lower
filesystem, an error is returned, but the bio->bi_status is not
marked as an error. However, the error information should be passed
to the end_io handler. Otherwise, the IO request will be treated as
successful.

Signed-off-by: Sheng Yong <shengyong1@xiaomi.com>
Reviewed-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
 fs/erofs/fileio.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/erofs/fileio.c b/fs/erofs/fileio.c
index bec4b56b3826..4fa0a0121288 100644
--- a/fs/erofs/fileio.c
+++ b/fs/erofs/fileio.c
@@ -32,6 +32,8 @@ static void erofs_fileio_ki_complete(struct kiocb *iocb, long ret)
 		ret = 0;
 	}
 	if (rq->bio.bi_end_io) {
+		if (ret < 0 && !rq->bio.bi_status)
+			rq->bio.bi_status = errno_to_blk_status(ret);
 		rq->bio.bi_end_io(&rq->bio);
 	} else {
 		bio_for_each_folio_all(fi, &rq->bio) {
-- 
2.43.0


