Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E88E6D663C
	for <lists+linux-erofs@lfdr.de>; Tue,  4 Apr 2023 16:56:44 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4PrW7G0Wm9z3cMT
	for <lists+linux-erofs@lfdr.de>; Wed,  5 Apr 2023 00:56:42 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=OhTg828Q;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=OhTg828Q;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=redhat.com (client-ip=170.10.133.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=aalbersh@redhat.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=OhTg828Q;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=OhTg828Q;
	dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4PrW6S6KnCz3cj3
	for <linux-erofs@lists.ozlabs.org>; Wed,  5 Apr 2023 00:56:00 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1680620158;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2wyXRFn15U7YuTtccu17S72kQxdrsvbnQJV5citpTBw=;
	b=OhTg828QI8HY4A07yqGxQ09dPVncS78FgkRdPNGz//G4sPxB584W9rt0bdNxNYNNrmG+si
	hvsEfDvfSzv5Wv4tvhy5/kq7ZL3V5Pbe2Hq8PpPT57apRfkV9DiRGL+mnxoKnBTnnDYcpH
	glH/ok58Cvu9McgEFFYLqw1ScflzTfk=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1680620158;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2wyXRFn15U7YuTtccu17S72kQxdrsvbnQJV5citpTBw=;
	b=OhTg828QI8HY4A07yqGxQ09dPVncS78FgkRdPNGz//G4sPxB584W9rt0bdNxNYNNrmG+si
	hvsEfDvfSzv5Wv4tvhy5/kq7ZL3V5Pbe2Hq8PpPT57apRfkV9DiRGL+mnxoKnBTnnDYcpH
	glH/ok58Cvu9McgEFFYLqw1ScflzTfk=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-528-zg0bnTh_MzmvrptAQEMByQ-1; Tue, 04 Apr 2023 10:55:57 -0400
X-MC-Unique: zg0bnTh_MzmvrptAQEMByQ-1
Received: by mail-qt1-f200.google.com with SMTP id v7-20020a05622a188700b003e0e27bbc2eso22247736qtc.8
        for <linux-erofs@lists.ozlabs.org>; Tue, 04 Apr 2023 07:55:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680620156;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2wyXRFn15U7YuTtccu17S72kQxdrsvbnQJV5citpTBw=;
        b=HIr237wryY77J7Kx+vjr9KgBZqtPcKD/bqACvICG6eIQe9n4FEMT56n3OBRWN1/FfT
         2Gk7DfFUv1yrCWXkdM88ZTWEinn7eTZ5CPdLv36mefv+e38znjR/3hmckUIgrM8d8dR7
         Q63FsQIfmETvsgV0/myUDJmLxEmgER4dOnqyn2u0iwq0iCIL0qHIaERy7I/hzeZ880/Y
         NhhWr06II/udBAHHsEpJ4bdLgt5OGL9kpjUp69s99bX7QTMy1drMcaRaurLuz/KKpSH2
         njH0eY7Aam7FVersMlQotQin96dYpmGGmRCrtNzjQEWncId/zqAttscxgVjPerLLjAtH
         ETFw==
X-Gm-Message-State: AAQBX9dgAR1RiDcP9opQobdvlcUMUWCTdBwaQ4RBsYOt6TdEb9f9NTPr
	o8moiOySMbw2SuN3Bd36nqON5EM0aui5Iprk/O/HHANlVBlQiiyzH4AsY/gZlw/60sEzZbe1e70
	Z7DgqtedTncCAbl4Resnkiz8=
X-Received: by 2002:a05:6214:202b:b0:57e:67c2:b9cd with SMTP id 11-20020a056214202b00b0057e67c2b9cdmr4447879qvf.27.1680620156133;
        Tue, 04 Apr 2023 07:55:56 -0700 (PDT)
X-Google-Smtp-Source: AKy350bJb0tNOFsr5rCdSnciXn4UvwnouNwwbFSTjZxZAVItCMscXXWD/V0CsYzmlqPKXH2vmnAZgg==
X-Received: by 2002:a05:6214:202b:b0:57e:67c2:b9cd with SMTP id 11-20020a056214202b00b0057e67c2b9cdmr4447836qvf.27.1680620155884;
        Tue, 04 Apr 2023 07:55:55 -0700 (PDT)
Received: from aalbersh.remote.csb ([109.183.6.197])
        by smtp.gmail.com with ESMTPSA id j4-20020ac86644000000b003e6387431dcsm3296539qtp.7.2023.04.04.07.55.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Apr 2023 07:55:55 -0700 (PDT)
From: Andrey Albershteyn <aalbersh@redhat.com>
To: djwong@kernel.org,
	dchinner@redhat.com,
	ebiggers@kernel.org,
	hch@infradead.org,
	linux-xfs@vger.kernel.org,
	fsverity@lists.linux.dev
Subject: [PATCH v2 22/23] xfs: add fs-verity ioctls
Date: Tue,  4 Apr 2023 16:53:18 +0200
Message-Id: <20230404145319.2057051-23-aalbersh@redhat.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20230404145319.2057051-1-aalbersh@redhat.com>
References: <20230404145319.2057051-1-aalbersh@redhat.com>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"; x-default=true
X-BeenThere: linux-erofs@lists.ozlabs.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Development of Linux EROFS file system <linux-erofs.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linux-erofs>,
 <mailto:linux-erofs-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linux-erofs/>
List-Post: <mailto:linux-erofs@lists.ozlabs.org>
List-Help: <mailto:linux-erofs-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linux-erofs>,
 <mailto:linux-erofs-request@lists.ozlabs.org?subject=subscribe>
Cc: linux-ext4@vger.kernel.org, agruenba@redhat.com, damien.lemoal@opensource.wdc.com, linux-f2fs-devel@lists.sourceforge.net, cluster-devel@redhat.com, rpeterso@redhat.com, jth@kernel.org, linux-erofs@lists.ozlabs.org, Andrey Albershteyn <aalbersh@redhat.com>, linux-btrfs@vger.kernel.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Add fs-verity ioctls to enable, dump metadata (descriptor and Merkle
tree pages) and obtain file's digest.

Signed-off-by: Andrey Albershteyn <aalbersh@redhat.com>
---
 fs/xfs/xfs_ioctl.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/fs/xfs/xfs_ioctl.c b/fs/xfs/xfs_ioctl.c
index 3d6d680b6cf3..ffa04f0aed4a 100644
--- a/fs/xfs/xfs_ioctl.c
+++ b/fs/xfs/xfs_ioctl.c
@@ -42,6 +42,7 @@
 #include <linux/mount.h>
 #include <linux/namei.h>
 #include <linux/fileattr.h>
+#include <linux/fsverity.h>
 
 /*
  * xfs_find_handle maps from userspace xfs_fsop_handlereq structure to
@@ -2154,6 +2155,22 @@ xfs_file_ioctl(
 		return error;
 	}
 
+	case FS_IOC_ENABLE_VERITY:
+		if (!xfs_has_verity(mp))
+			return -EOPNOTSUPP;
+		return fsverity_ioctl_enable(filp, (const void __user *)arg);
+
+	case FS_IOC_MEASURE_VERITY:
+		if (!xfs_has_verity(mp))
+			return -EOPNOTSUPP;
+		return fsverity_ioctl_measure(filp, (void __user *)arg);
+
+	case FS_IOC_READ_VERITY_METADATA:
+		if (!xfs_has_verity(mp))
+			return -EOPNOTSUPP;
+		return fsverity_ioctl_read_metadata(filp,
+						    (const void __user *)arg);
+
 	default:
 		return -ENOTTY;
 	}
-- 
2.38.4

