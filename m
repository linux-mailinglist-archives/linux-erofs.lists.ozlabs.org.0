Return-Path: <linux-erofs+bounces-588-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9071EB02185
	for <lists+linux-erofs@lfdr.de>; Fri, 11 Jul 2025 18:18:37 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4bdxj72d8Mz30V7;
	Sat, 12 Jul 2025 02:18:35 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::430"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1752250715;
	cv=none; b=YHX/SngwR8uaEWXy2Xnw+jwMSlAkBni39S3v9/iKDP8AzZpSVOHHGBgMVB8Rd6wjb2OfKufsNaOTy+pAoJKe5/wrha7l0hQOsQ/mRg9aNPsOk1zeEGfBPZipHoDFqRqwR1Uec4pMo2peruUYUFCrx2lyVFdnSfyxi2A4KzSfaegwH2QDDKGgOOQ1bpye5K1kKRxRvTHZXVReDTv/2GSnoSbpNlf+1ailGK1MiOeBHz51MthSHjbNNLVMYMKQrM6JDem726uqL5u7QX8YiBI0yD1cxrXXpBfCBKtckbuA4aajKHUwtNiO79OzvjAHT9FNFurWfq8qcQo+R8M6YQDPnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1752250715; c=relaxed/relaxed;
	bh=qp9438Ap5pgDCATpoMu0agZ1MP+IzIRW9lUxjF4qaQo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gxeBvuTVzF8UfwLoBslwG8vPsrL/XgSeqEptooAITTEUXnockwQen71g6w4+/YcwoKNVrjR7TkP+m+RfB/AssRzeUJvdrT71FVjomod1orY7Ff2U2RlyrPvxcl541tVnOvFCXf+TVHRUiyiZ93IZaTbMVOq5l16OxLRm5KM6hTg/rVJqDVvEI9MbVIc1GLcvrHJYp/iV+lsCqdSJnflfgMf3eyo86f1SZRVm3ucygK7DqtS4fJOx21Xz3s9BMK+Vb2/lVF+fBPDFAnTxOlP3aHromORyMlgoPDIr+n5UXG6evqh3qT10Aku8tUc74hZffWfGSA+EvSBdcatuu2unjw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=SP2V1208; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::430; helo=mail-pf1-x430.google.com; envelope-from=stopire@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=SP2V1208;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::430; helo=mail-pf1-x430.google.com; envelope-from=stopire@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4bdxj65f8Cz2xfB
	for <linux-erofs@lists.ozlabs.org>; Sat, 12 Jul 2025 02:18:34 +1000 (AEST)
Received: by mail-pf1-x430.google.com with SMTP id d2e1a72fcca58-7426c44e014so2290189b3a.3
        for <linux-erofs@lists.ozlabs.org>; Fri, 11 Jul 2025 09:18:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752250713; x=1752855513; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qp9438Ap5pgDCATpoMu0agZ1MP+IzIRW9lUxjF4qaQo=;
        b=SP2V12081sAKXmPINeylzKocDJW0sIvm+9439ykkhH/gcyjjOr9GlR7uTIyw0WccmU
         V5i22LADJf6Tb4XWOIrd9yvMvCedLwJUiHUh5HHGHHcUe56TScvwBnqlC5lA2T4ZCoto
         e4Ya3G8y37cKdBNWrXLOx7ocf7uFNIx/qktTuSAGeneGaM7w7Omi84JO1sQIkrZBG0jh
         hJqLgvqKp58cWVsaM52mioLD7uPARiCZ+skoODNGlwRiXBneC6tmj7ecrUpcHYdrtoJw
         v5jgXr/QCRRzZgsNMTzpR5yNMuCwyOIhPCj+MXvUjmiL7Xk39bETfQjfVHEgjthXOhpF
         L1iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752250713; x=1752855513;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qp9438Ap5pgDCATpoMu0agZ1MP+IzIRW9lUxjF4qaQo=;
        b=j47n4mAA+w16JtK8vMChq++lePZhT4rWipvm/EiGP/MZtCM/e0k9r5LOe/CrxoI/cv
         0oEoLHvtHRmkGoqSgkkuxw6To8C+wYOFLGLOCzPJVajWd4HMcG2E2+DRh04KX+G6Gp3M
         IDQUSLLDhj+eZ3Psm/g7mGX5kqnW0gCCBOz6cKqZSTdOwg7AzBoOo2nobEQf+hqIh3+v
         PT4E94g+lbZ2n/m8U2VcdmODVVSlUiLO1ok486zhVpdl/RkTmHklP9+7j2+yLWfAPQ8J
         ptjyDXUJjayccSorUL8o1xy/mq7O4jznW2BXGLLS4uz0cHrWo5lhY+QPF1J+E54hPibT
         oNOQ==
X-Gm-Message-State: AOJu0Yxp4yYfgqE2+LrGnJa3oQ+y7j2k8szUaB5lkQE4ouYEIVC0a1+p
	JWi6kArbgtRQrThroySYF2TN0vhuvqvoKCg0tBTUHSMumM8fO+6/JWAmnhP9t7eS60Q=
X-Gm-Gg: ASbGncvBmohsq98wPUwnRSYqURUX4hg8y96ix/d5/m3moHbzzjox1qUP/Qhn/5poJ3J
	5fplZ1QXQHtOvIgLa30qssnmnQ9U4NglR7j8EPh0G9+GBgqThGb9IxmhvZwfmjUbyaSv8ok7EKl
	uolCMMS+qrVvWy3n7k/JmfzsmQaR9xzGPhHPYyC0vZPVEPBSjd7fVCvS3xbv8YSHjtKJeLWaG4J
	lfqwv+OKLWoTKNQFvSIAgWLK43t5Q3TRZzss2hzrSLqNV2RC7wkKx2JOov+FbEGQhITKIOsKjbE
	q+9ZKNTs+esXk0+qxqO1yEfccaZ2kuR4CjL2U5BYR9kt+9CS/z23bBh9/fiuInXaxwDszGRlgPO
	IUVuWefkv5F9mbvt2dSca/fpaQGdYHh4arlevITY=
X-Google-Smtp-Source: AGHT+IHk/Ul+4YORNfdkBmaMEFy/fcZxGFIZ1PPNk0pR5BhLLj3orUP0OOx53godkDtGG1qI1xSzoA==
X-Received: by 2002:a05:6a00:10cf:b0:748:f3b0:4db6 with SMTP id d2e1a72fcca58-74f1e7dffdfmr4235448b3a.11.1752250712604;
        Fri, 11 Jul 2025 09:18:32 -0700 (PDT)
Received: from ZYF-PC.localdomain ([112.64.104.104])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-74eb9e075e2sm5865280b3a.52.2025.07.11.09.18.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Jul 2025 09:18:32 -0700 (PDT)
From: Yifan Zhao <stopire@gmail.com>
To: linux-erofs@lists.ozlabs.org
Cc: Yifan Zhao <stopire@gmail.com>
Subject: [PATCH 1/2] erofs-utils: lib: fix uninitialized variable access in bmgr
Date: Sat, 12 Jul 2025 00:16:14 +0800
Message-ID: <20250711161615.44832-2-stopire@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250711161615.44832-1-stopire@gmail.com>
References: <20250711161615.44832-1-stopire@gmail.com>
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
	DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org

Missing `bmgr->metablkcnt` initialization leads to an uninitialized
variable access, fix it.

Signed-off-by: Yifan Zhao <stopire@gmail.com>
---
 lib/cache.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/lib/cache.c b/lib/cache.c
index 2c73016..b3cf1c4 100644
--- a/lib/cache.c
+++ b/lib/cache.c
@@ -52,6 +52,7 @@ struct erofs_bufmgr *erofs_buffer_init(struct erofs_sb_info *sbi,
 	bmgr->blkh.blkaddr = EROFS_NULL_ADDR;
 	bmgr->tail_blkaddr = startblk;
 	bmgr->last_mapped_block = &bmgr->blkh;
+	bmgr->metablkcnt = 0;
 	bmgr->dsunit = 0;
 	return bmgr;
 }
-- 
2.43.0


