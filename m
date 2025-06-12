Return-Path: <linux-erofs+bounces-396-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D480AD6D65
	for <lists+linux-erofs@lfdr.de>; Thu, 12 Jun 2025 12:18:36 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4bHz561WVrz2xQ6;
	Thu, 12 Jun 2025 20:18:34 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::1049"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1749723514;
	cv=none; b=Mex32TYYNJWl8VeY7BqxU1kYRGMN3WAcKZ7O+iwb2PpYBXCU6uN323826IvoZhEJhNHCZwdCgAVGfiOE4msyShCiAzRZsmpL1Phfrs61y4GiHkkgRXR42e/THh7D9ARptndvLBP/jplIf/6YohnOYO4zsbfKV/SyQR5CjW/uloMeRi5PGMUjaZpLQc7nnYtJobKPPG74tImzPt7pUCcJxy98sPNhSymV92Ue5A6O+vRsZymr+XqTIe4h0jGDPDGleqTrtwrn8K5lkZOTyBMDisQwEISqKNvkAce7MOfX2KekCyb7xSfFhny/pWrdqNlTrWGz0beW4YwXDo9zp7VOnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1749723514; c=relaxed/relaxed;
	bh=20a6VXdSyZR3J7DOvNrBbIXfn2ygPO/nSrCWCnB/1y0=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=fIn90YwC5rzMa+sfIPddj/cLIWThXZgdWxf9Bl7BVSIxC29T8QL1zzahHmdnXofqGQiiNZDwJbcZGAysM/VJHm9dRTfaZN2TFUJv5CwudSWguPb81pdrwjb12bc/KEojeZg6X6JlCArfHeAGcsxBFEYBe/oS7XHtwHyYVUyuoPFLaDytKbKXZ2exND7VexHJSOlcwhweGNyq7+FS+M98mGfPqIFXVm1l7vAtPyTi0BW3OJt0kKgXjpPQLiiEF/QbFRKldCqCPQge4tTxi2Q2HhtL3jpD9Ph1D64TFEJkMtaxaAWo6UPNQgTZA8OenQMqIjfOg2t/uAzRKFfRt6g1+Q==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com; dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20230601 header.b=D1E7qSx/; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::1049; helo=mail-pj1-x1049.google.com; envelope-from=3dalkaa0kczwgqfgryrqswsigemmejc.amkjglsv-cpmdqjgqrq.mxjyzq.mpe@flex--ishitatsuyuki.bounces.google.com; receiver=lists.ozlabs.org) smtp.mailfrom=flex--ishitatsuyuki.bounces.google.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20230601 header.b=D1E7qSx/;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=flex--ishitatsuyuki.bounces.google.com (client-ip=2607:f8b0:4864:20::1049; helo=mail-pj1-x1049.google.com; envelope-from=3dalkaa0kczwgqfgryrqswsigemmejc.amkjglsv-cpmdqjgqrq.mxjyzq.mpe@flex--ishitatsuyuki.bounces.google.com; receiver=lists.ozlabs.org)
Received: from mail-pj1-x1049.google.com (mail-pj1-x1049.google.com [IPv6:2607:f8b0:4864:20::1049])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4bHz546ySvz2xFl
	for <linux-erofs@lists.ozlabs.org>; Thu, 12 Jun 2025 20:18:32 +1000 (AEST)
Received: by mail-pj1-x1049.google.com with SMTP id 98e67ed59e1d1-311cc665661so773450a91.2
        for <linux-erofs@lists.ozlabs.org>; Thu, 12 Jun 2025 03:18:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1749723509; x=1750328309; darn=lists.ozlabs.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=20a6VXdSyZR3J7DOvNrBbIXfn2ygPO/nSrCWCnB/1y0=;
        b=D1E7qSx/Mc1su5f7J75z7AA8Hkp2HhUMZqzneV2tEkadVyriw/+bsJuJDUAro3GUJz
         2cshVmLp2Zx8RaUCFi1WuRNzM/CHP1+Ct/xh/hC3eQ1M61WRshpBRR61aXJ/Z3m+NJhF
         k17vFnS4+7kmmXWMbgTHHpDeAtuVWCJJYR6z8mcNbuQSHCLpkX74+EwUGNaL0gt+f3S+
         zjWX+kq5GQdH8hrmixm578w2DGj8LCVXZ4FhlXvT9lAbyCRgxvpfT0K6+MluT5Ec7IJ3
         aoUi9DuRULvqSMJQPenVxRcmiBkBY0bLamUNoKcSHLBTOY42BFXgHvRzn5Fdj/2h+mFT
         sDlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749723509; x=1750328309;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=20a6VXdSyZR3J7DOvNrBbIXfn2ygPO/nSrCWCnB/1y0=;
        b=j+KBslPWeSHxgUC2HTXjorQ6qbRUf2RPAvxX45tElfHbO2jN5rLa83aU+YYXCEz5Ef
         DIEps3Id73zSkP1HqnKBm3zH/FNUD775GkZUgVH3/FH2h6tNWV1IA8OA+bOWz07Ba6PX
         QbGgS3Dz351sFTZrKX2PpmmdNbGEAIuLLUfUij7Wb9DcPos3FyjvdMhQnKnbo5CX3130
         punB18ZLvcGHaG44ot/FRO3RN3ol0PE8wQ2C6jPQAGsvrdO8P3Hp0IQpLBKFNQliia2P
         6o5Am/BgTbag8uKuOvmX47nq1uIIhgOr6K10u96xBQeKFuKHKUecGJsaCUv0DNkftQLD
         Z8LQ==
X-Gm-Message-State: AOJu0Yw7+UXT6dE3bOtlILu1KERjEkzfZsYeshN735BCP92K1QyNjowU
	Z4eJA4aEQx2HRo/fSrfmjibMhF7iN35JRUNXdEHPciKo5PI8DMgz0Ab8Mo0d0K+5M34VuQN127J
	vci/cvck+SGD0jv9VqeC3iSK9EMmd6du+Fw==
X-Google-Smtp-Source: AGHT+IG9MR2SuFSzKZgWA0YQQQQgsFeVnjAS9ApDfDEl5sU6JXYo/aqTjv0GcbwrVoAVUpr1Cw8h6otWmq1nzp26ZPVf
X-Received: from pjbst13.prod.google.com ([2002:a17:90b:1fcd:b0:312:1c59:43a6])
 (user=ishitatsuyuki job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:1c09:b0:312:e8ed:758 with SMTP id 98e67ed59e1d1-313bfb677c7mr4388239a91.13.1749723509379;
 Thu, 12 Jun 2025 03:18:29 -0700 (PDT)
Date: Thu, 12 Jun 2025 19:18:25 +0900
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
Mime-Version: 1.0
X-B4-Tracking: v=1; b=H4sIAHCpSmgC/x3MMQqAMAxA0atIZgMatKBXEYdao2awlUREEO9uc
 XzD/w8Yq7BBXzygfIlJihl1WUDYfFwZZc4GqqitXE04NciaFkPZD1ZL0Z+MswvUkQutCx5yeig vcv/bYXzfD5Bjg8tmAAAA
X-Change-Id: 20250612-b4-erofs-impersonate-d6c2926c56ca
X-Mailer: b4 0.14.2
Message-ID: <20250612-b4-erofs-impersonate-v1-1-8ea7d6f65171@google.com>
Subject: [PATCH] erofs: impersonate the opener's credentials when accessing
 backing file
From: Tatsuyuki Ishi <ishitatsuyuki@google.com>
To: Gao Xiang <xiang@kernel.org>, Chao Yu <chao@kernel.org>, Yue Hu <zbestahu@gmail.com>, 
	Jeffle Xu <jefflexu@linux.alibaba.com>, Sandeep Dhavale <dhavale@google.com>, 
	Hongbo Li <lihongbo22@huawei.com>
Cc: linux-erofs@lists.ozlabs.org, linux-kernel@vger.kernel.org, 
	shengyong1@xiaomi.com, wangshuai12@xiaomi.com, 
	Tatsuyuki Ishi <ishitatsuyuki@google.com>
Content-Type: text/plain; charset="utf-8"
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
	USER_IN_DEF_DKIM_WL autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org

Previously, file operations on a file-backed mount used the current
process' credentials to access the backing FD. Attempting to do so on
Android lead to SELinux denials, as ACL rules on the backing file (e.g.
/system/apex/foo.apex) is restricted to a small set of process.
Arguably, this error is redundant and leaking implementation details, as
access to files on a mount is already ACL'ed by path.

Instead, override to use the opener's cred when accessing the backing
file. This makes the behavior similar to a loop-backed mount, which
uses kworker cred when accessing the backing file and does not cause
SELinux denials.

Signed-off-by: Tatsuyuki Ishi <ishitatsuyuki@google.com>
---
 fs/erofs/fileio.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/fs/erofs/fileio.c b/fs/erofs/fileio.c
index 7d81f504bff08f3d5c5d44d131460df5c3e7847d..df5cc63f2c01eb5e7ec4afab9e054ea12cea7175 100644
--- a/fs/erofs/fileio.c
+++ b/fs/erofs/fileio.c
@@ -47,6 +47,7 @@ static void erofs_fileio_ki_complete(struct kiocb *iocb, long ret)
 
 static void erofs_fileio_rq_submit(struct erofs_fileio_rq *rq)
 {
+	const struct cred *old_cred;
 	struct iov_iter iter;
 	int ret;
 
@@ -60,7 +61,9 @@ static void erofs_fileio_rq_submit(struct erofs_fileio_rq *rq)
 		rq->iocb.ki_flags = IOCB_DIRECT;
 	iov_iter_bvec(&iter, ITER_DEST, rq->bvecs, rq->bio.bi_vcnt,
 		      rq->bio.bi_iter.bi_size);
+	old_cred = override_creds(rq->iocb.ki_filp->f_cred);
 	ret = vfs_iocb_iter_read(rq->iocb.ki_filp, &rq->iocb, &iter);
+	revert_creds(old_cred);
 	if (ret != -EIOCBQUEUED)
 		erofs_fileio_ki_complete(&rq->iocb, ret);
 }

---
base-commit: cd2e103d57e5615f9bb027d772f93b9efd567224
change-id: 20250612-b4-erofs-impersonate-d6c2926c56ca

Best regards,
-- 
Tatsuyuki Ishi <ishitatsuyuki@google.com>


