Return-Path: <linux-erofs+bounces-162-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id EB3FBA80623
	for <lists+linux-erofs@lfdr.de>; Tue,  8 Apr 2025 14:24:47 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4ZX4yj3prDz306l;
	Tue,  8 Apr 2025 22:24:45 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::429"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1744115085;
	cv=none; b=KEixsnw6bIpw8d9pxdeSTMae+S7SM2qSULtAjP6+j8vKlsH5VSAIeIWEkonr2W7eYFvytuUxXd3JBAwwVfPXPrlemZGZqHeI3d6t/0ju6LjUJtTQtlDbF3ZQKrxMSep0ESaXznAD9WbQxF6/MEn3ojv2c1u4IhziO9fHQ0Z0OcHaXgXA7smVUtiLs03nIZ062Wz36UDQFbb/P0Lz62BPZsqQhtf9Khs1VlZLue5ySL2B9O0M8EPzRevDIv2kZaK1uMG6M9UAAq94Q7q5ZaBfor2NsOC+bPxdU6T5WvdLTe3ZrXxwDjCYvVZ2zF+IuyVfuqrjO1liXn948FYBYbRppg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1744115085; c=relaxed/relaxed;
	bh=ZOptbtbOKUdHNzNg9ygqhPthLmzyP2uo7jPEq6N+YNQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ERSCI61Ata1h4fHLDwxlSHQGGGDxq65fG6LNT6aNGU654Sfn0d9AAZxO6SJQpiAbPFfLqXhByARuARGTEo7hyz1iJqiKa6vqRfaOn93kLoO27cUoGvWZ5/0TdyfRrTHDqJxtpDdK1mWvH5WXPy8/wo22WE2rjj43RuqtOljd7zUIdVZX+1oavejsv4/HpxhP0FvrxM0FYAJAT6WsgBzcmsIZl+kjQcqNjFFetdhWXaryI350PCUb8NgXJs571WbyBv+VE/yGbS2fgyzDUahjOHW/eePjpFnVYcMUS5c5fX5kelqm4JwRrRqDpaPHENpQ5gOsrPBHFjQLKJUmLL/7lw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=eVb3FRio; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::429; helo=mail-pf1-x429.google.com; envelope-from=shengyong2021@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=eVb3FRio;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::429; helo=mail-pf1-x429.google.com; envelope-from=shengyong2021@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4ZX4yh1LbBz301v
	for <linux-erofs@lists.ozlabs.org>; Tue,  8 Apr 2025 22:24:43 +1000 (AEST)
Received: by mail-pf1-x429.google.com with SMTP id d2e1a72fcca58-7398d65476eso4225093b3a.1
        for <linux-erofs@lists.ozlabs.org>; Tue, 08 Apr 2025 05:24:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744115081; x=1744719881; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ZOptbtbOKUdHNzNg9ygqhPthLmzyP2uo7jPEq6N+YNQ=;
        b=eVb3FRiokSfQLff46PA5HAm0QUF6H4CJubIZV9WYIIR7/x40ULx9KE5Z9P3fkmGZEK
         O9VfOesN1OvJbbdQDgQ27QjVUcr1KTYBIKT7yN6BtVoRP6CoMPGPJD5HRFjjiK1zxRZB
         9SXVDHDg4GaEoC4QZcckaTsLfGKH5UhG/1EaaaeLjeXI0cBplHIXMuqOa9diupOKNV77
         w7J9AKZoxjOG7mJ8//aHhjfQURiG8/Pap1PZCxatHOYOvt/2ksL2UsBqIyWvOX8UcErG
         tH8fKPR89NizFyXICl16IphuDwXRXhqCwZ8OOOs5GA/ZMkZ4FaiiZEvxMeiT7f4dIACt
         gNqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744115081; x=1744719881;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZOptbtbOKUdHNzNg9ygqhPthLmzyP2uo7jPEq6N+YNQ=;
        b=AzDuHQ4b6Hjv5iPK0I9tJv7yfUjHDbrxgw/RbcXIV1EOz65WtWwwcfV19MTDKJ5z+d
         Mmb53ddc+9tofsNEn6s95CfYOnTREGhEbfHhZqBsQEoUmI1qkYcejvdoeIUyK3TsMC59
         jm3SxR2AZXgqgT20Pxu3sRE2w/4uXNHO0gI1cvawxfQKCCvCuNsI0UXcKS1cLFdXo/Np
         nHkPCL9e6OcV+x3FFaHp34i5dfM2LGyc/R57KbA7n7q7maSCGO4xPGGzVxSu+LxM0LUd
         fpxg2lZRb1nHPg9of5VPRCs7QXTt9z+UVl89gKe7YkLDd33KSQojYpXNYSfh13b5EvPm
         ppnA==
X-Gm-Message-State: AOJu0YxblfXkDNTtyx7UU32HrHuV6x/wVLGFvH/3LDh32E0Y1NrB7aHY
	ybuzSOMZH7OLMsY71AYR8+8EySoMnxxvyG4O0wk40RBCaqogxYaZ
X-Gm-Gg: ASbGnctOglCeVhmaIhOrSjsUES2wHEJwkXZbgyqCY1dOV9kj/5EcNfHYSWTEn5vHjZT
	VEFhWlW/Q169DNiT2bhiG+fffufEqPN7BVCbLORqYIjg17NWG2LnTlgjsTXswUaOlmCH/kjMOwb
	FQTts84E2Z/4GW6RDcB/e6uusb5/yCewFvCYIoBHWSDW+2eRuwYFCqB+APBrZYo4xJEigqmUE19
	/fBu3pgGKZW40LQlJhKV1Wgn6vhoG6QB9Fw+FZRbnrHVOk+CGmgoL5MhXeb/AsxTo81ZvxJyyRN
	uwkHFHe/ew9NcYXIDU8ZkxASuLFa/dnJYjlPU/ml05VeUaaqWsI=
X-Google-Smtp-Source: AGHT+IEHpcmo7Xhh/kVuzYomYKxOSWeOPsROUGdAglsdVSxwiKJVQSvQkVzHe2m4jPEycQAEtJwafA==
X-Received: by 2002:a05:6a00:114f:b0:736:491b:5370 with SMTP id d2e1a72fcca58-73b9d39ee5fmr4601812b3a.10.1744115080611;
        Tue, 08 Apr 2025 05:24:40 -0700 (PDT)
Received: from PC.mioffice.cn ([43.224.245.227])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-739da0b41d4sm10638709b3a.132.2025.04.08.05.24.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Apr 2025 05:24:40 -0700 (PDT)
From: Sheng Yong <shengyong2021@gmail.com>
X-Google-Original-From: Sheng Yong <shengyong1@xiaomi.com>
To: xiang@kernel.org,
	hsiangkao@linux.alibaba.com,
	chao@kernel.org,
	zbestahu@gmail.com,
	jefflexu@linux.alibaba.com,
	dhavale@google.com,
	kzak@redhat.com
Cc: linux-erofs@lists.ozlabs.org,
	linux-kernel@vger.kernel.org,
	wangshuai12@xiaomi.com,
	Sheng Yong <shengyong1@xiaomi.com>
Subject: [PATCH v4 1/2] erofs: set error to bio if file-backed IO fails
Date: Tue,  8 Apr 2025 20:23:50 +0800
Message-ID: <20250408122351.2104507-1-shengyong1@xiaomi.com>
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


