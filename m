Return-Path: <linux-erofs+bounces-251-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id AE623A9FD8B
	for <lists+linux-erofs@lfdr.de>; Tue, 29 Apr 2025 01:09:46 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4ZmfKg5k1Fz2yvv;
	Tue, 29 Apr 2025 09:09:43 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a00:1450:4864:20::629"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1745881783;
	cv=none; b=PnJvK+JZ0foP114zDOmo9Ok8sm5RGQ/hGZKGNjL60CQ+mL9C8Ie4Jceqpr8Xvwaqui9msxcOfe6T3eUvw30aLA7ZyqlYxNq6eC1bHqDN2sR1z7P3zfOJ/SDcc7GLgYEgNFxkYxfklZUSosRRqYzE8uXfE4F0OJKYfFWJNGpwMHoaJR3iPfp5yY5mEoLiLEzf3SHl7rR6Tv2jk+GuHZeoTKHazRV/9cnYPR7V9QHa7otZH1W8NrXYtQw+r3NeQGgut8d9XqJBjxkixnzBTunFYarUUjNEjXqXxw9M2jCQf6P7YIxBQffSV6ekhHAJ24ahUiU/l322uAVN9FKEIxf5Rw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1745881783; c=relaxed/relaxed;
	bh=vuwPRT6I+AQPMIHK3FEvwFoI62Ft+AE7bxY+V5erSDY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=FqJYBGEvMK/FohNkGJJGwb1zq80L6SwUGCKDQH0XVFEV0Ms6VQQzzMMizj7qxXEwypfA7xUvIk0XcdFlc8hOwRnBBI8kegXxVLtOVQK5NcUSWrAuoE1LE9ZXo2mfeZP+4FySHiF1Y29pi732+GcbPjDJJlHIWNgy6kTC1T8a5E+Jpoh5hgz78hDPNzqe3Gi/fpoFOifOKDYapiMs7S/LEI3PoyORdyD6oY2RHrCwbI5s39wNlgwdPvToxzzpWoHNlPYDDMny+yiWM2vRYRwNTlNp4hJdsFkwlHZUF9edT+MpRHJKm8zWMNxZDZKr46+HVCUjzorrcF5CZ65XY/5bPw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com; dkim=pass (2048-bit key; unprotected) header.d=ionos.com header.i=@ionos.com header.a=rsa-sha256 header.s=google header.b=NlyoSqKL; dkim-atps=neutral; spf=permerror (client-ip=2a00:1450:4864:20::629; helo=mail-ej1-x629.google.com; envelope-from=max.kellermann@ionos.com; receiver=lists.ozlabs.org) smtp.mailfrom=ionos.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ionos.com header.i=@ionos.com header.a=rsa-sha256 header.s=google header.b=NlyoSqKL;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=permerror (SPF Permanent Error: Void lookup limit of 2 exceeded) smtp.mailfrom=ionos.com (client-ip=2a00:1450:4864:20::629; helo=mail-ej1-x629.google.com; envelope-from=max.kellermann@ionos.com; receiver=lists.ozlabs.org)
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4ZmfKd5C45z2yvs
	for <linux-erofs@lists.ozlabs.org>; Tue, 29 Apr 2025 09:09:39 +1000 (AEST)
Received: by mail-ej1-x629.google.com with SMTP id a640c23a62f3a-acb415dd8faso740998566b.2
        for <linux-erofs@lists.ozlabs.org>; Mon, 28 Apr 2025 16:09:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1745881775; x=1746486575; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=vuwPRT6I+AQPMIHK3FEvwFoI62Ft+AE7bxY+V5erSDY=;
        b=NlyoSqKLV/3gB7j7PhWYQXOHX3QFVSKFPbwySH1BpX4FGroVrAIowQsjJavvbJApCF
         qzADMUq8Ht/lgrCa/5ce6Uc9zwYtsCQD3k9HGs0W2o9VFMQAlLdbu/QEZ5BjlMqJcK5b
         PYeHkQ9fSVQXbjLuavcEQ64sEFCJ55+OdwqP/HCIxNlY703429uugpFuyc+TEmccRbVN
         uDcrM+CU5uUvv6RLJYbT9tuFe5/dsWnb5xloiBmSQCrG2wjHMCTlYYEALexl4bzAsSfv
         gB2autI3tSmBpRJJqHXtZtjRSXjVqU+VfLrih4DcAsk6xLaRNz80IppPqA5IXJRwPNDP
         r6gQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745881775; x=1746486575;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vuwPRT6I+AQPMIHK3FEvwFoI62Ft+AE7bxY+V5erSDY=;
        b=OU3a+3IH6MC7gx1j4ePM8TtQR/YevGxX3SVfX+RVcwpopc7gvHZ7yY+MMx6ahLV0oY
         SY1vZfrE3Bwf8DsVcBblQLkYDKCEnCzzyxMRDgiBjz2ZjRGWs6dlTX+VG1ztCo4cJU9R
         K9027jZTQ3tovkTAc1iEjBTNQkgIOA82JtxvrnUPGYtlS73nXA7/fn290T5Z3HaoXsSD
         GuDiuWs2p0OEovOD9Oa2OU0jwE8LnqH0sTMFVATs9q1mx8expDdlPIZTqUasWtn++PDx
         V765ntay1P2ji63MESWOwi+D9RCYlLLLNneN6qylmFfr2oXf022TPftMVRiEZ9HNgHGv
         M0QQ==
X-Forwarded-Encrypted: i=1; AJvYcCXs9I3AG8KGGgGfRkvb7txNiLzsU0lRniHSy6DvVCvyqHgvfgH+/Spny7rTf/4D46+Q/kWOhnlyRQX17w==@lists.ozlabs.org
X-Gm-Message-State: AOJu0YxWm+Cxxng9DvCW4CPqnKs99OlXvYnB0ZXLCjbSbo1ozQn4NKTV
	UaXdTiIpOlv8NPAcBl8HDjMbdPR4tnW7u+lcCREKGma9IyRNJ4BVktPG1e2kCyk=
X-Gm-Gg: ASbGncus+KdwP6T8XfLNEAHnnjhC6F8CkHhHf4qIFUXl2k3ssDjl8JrkPeBOwtu6z6j
	S7WSiF4YBUjqhVZIx4xNqF7iIlwM6bfpSLhyOzphTW0xNeLQY0As21kStO9DtgBKqS65Lc9dQZz
	HV+B63J0E+2xayyBAvJOpLhshfpUtvWCdMjMQHRU+YYzMd9lg0izWh0paXczfE6i099UrPvvaDp
	uPJhMIY9ZvMWOfCI5rnfkbQ8xIfbVdhJhF72zrc91NGx/cSNojp7VVn4XTGqCQlZF0QUwRfk9cl
	YKVAmGevKRDBstygF+8uRle1T+z49nHi+Du5iykb2fmsyKKr7Gy+AfoC4mYL+G/KK1Snp0fiTbO
	ZPZQ3gdKiwyREPC7NmlBllLj4wSh7MrxCmrwa39nP
X-Google-Smtp-Source: AGHT+IE5dJK+12G6ixtMDx/8QmYuexDS2b/NTuouKDmQ+p4y/0Up7a/b/rL1ILFQJAuAfI+CdQ8jOw==
X-Received: by 2002:a17:907:940d:b0:ac7:b368:b193 with SMTP id a640c23a62f3a-acec4cdf8a0mr160727866b.27.1745881775464;
        Mon, 28 Apr 2025 16:09:35 -0700 (PDT)
Received: from raven.intern.cm-ag (p200300dc6f46c100023064fffe740809.dip0.t-ipconnect.de. [2003:dc:6f46:c100:230:64ff:fe74:809])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ace6e595abfsm687547266b.86.2025.04.28.16.09.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Apr 2025 16:09:35 -0700 (PDT)
From: Max Kellermann <max.kellermann@ionos.com>
To: xiang@kernel.org,
	chao@kernel.org,
	zbestahu@gmail.com,
	jefflexu@linux.alibaba.com,
	dhavale@google.com,
	linux-erofs@lists.ozlabs.org,
	linux-kernel@vger.kernel.org
Cc: Max Kellermann <max.kellermann@ionos.com>,
	stable@vger.kernel.org
Subject: [PATCH] fs/erofs/fileio: call erofs_onlinefolio_split() after bio_add_folio()
Date: Tue, 29 Apr 2025 01:09:33 +0200
Message-ID: <20250428230933.3422273-1-max.kellermann@ionos.com>
X-Mailer: git-send-email 2.47.2
X-Mailing-List: linux-erofs@lists.ozlabs.org
List-Id: <linux-erofs.lists.ozlabs.org>
List-Help: <mailto:linux-erofs+help@lists.ozlabs.org>
List-Owner: <mailto:linux-erofs+owner@lists.ozlabs.org>
List-Post: <mailto:linux-erofs@lists.ozlabs.org>
List-Subscribe: <mailto:linux-erofs+subscribe@lists.ozlabs.org>,
  <mailto:linux-erofs+subscribe-digest@lists.ozlabs.org>,
  <mailto:linux-erofs+subscribe-nomail@lists.ozlabs.org>
List-Unsubscribe: <mailto:linux-erofs+unsubscribe@lists.ozlabs.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
	T_SPF_PERMERROR autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org

If bio_add_folio() fails (because it is full),
erofs_fileio_scan_folio() needs to submit the I/O request via
erofs_fileio_rq_submit() and allocate a new I/O request with an empty
`struct bio`.  Then it retries the bio_add_folio() call.

However, at this point, erofs_onlinefolio_split() has already been
called which increments `folio->private`; the retry will call
erofs_onlinefolio_split() again, but there will never be a matching
erofs_onlinefolio_end() call.  This leaves the folio locked forever
and all waiters will be stuck in folio_wait_bit_common().

This bug has been added by commit ce63cb62d794 ("erofs: support
unencoded inodes for fileio"), but was practically unreachable because
there was room for 256 folios in the `struct bio` - until commit
9f74ae8c9ac9 ("erofs: shorten bvecs[] for file-backed mounts") which
reduced the array capacity to 16 folios.

It was now trivial to trigger the bug by manually invoking readahead
from userspace, e.g.:

 posix_fadvise(fd, 0, st.st_size, POSIX_FADV_WILLNEED);

This should be fixed by invoking erofs_onlinefolio_split() only after
bio_add_folio() has succeeded.  This is safe: asynchronous completions
invoking erofs_onlinefolio_end() will not unlock the folio because
erofs_fileio_scan_folio() is still holding a reference to be released
by erofs_onlinefolio_end() at the end.

Fixes: ce63cb62d794 ("erofs: support unencoded inodes for fileio")
Fixes: 9f74ae8c9ac9 ("erofs: shorten bvecs[] for file-backed mounts")
Cc: stable@vger.kernel.org
Signed-off-by: Max Kellermann <max.kellermann@ionos.com>
---
 fs/erofs/fileio.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/erofs/fileio.c b/fs/erofs/fileio.c
index 4fa0a0121288..60c7cc4c105c 100644
--- a/fs/erofs/fileio.c
+++ b/fs/erofs/fileio.c
@@ -150,10 +150,10 @@ static int erofs_fileio_scan_folio(struct erofs_fileio *io, struct folio *folio)
 				io->rq->bio.bi_iter.bi_sector = io->dev.m_pa >> 9;
 				attached = 0;
 			}
-			if (!attached++)
-				erofs_onlinefolio_split(folio);
 			if (!bio_add_folio(&io->rq->bio, folio, len, cur))
 				goto io_retry;
+			if (!attached++)
+				erofs_onlinefolio_split(folio);
 			io->dev.m_pa += len;
 		}
 		cur += len;
-- 
2.47.2


