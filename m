Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id B02686EECE9
	for <lists+linux-erofs@lfdr.de>; Wed, 26 Apr 2023 06:12:46 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Q5lp24Frlz3c6v
	for <lists+linux-erofs@lfdr.de>; Wed, 26 Apr 2023 14:12:42 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20221208 header.b=FkNan6se;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::535; helo=mail-pg1-x535.google.com; envelope-from=zbestahu@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20221208 header.b=FkNan6se;
	dkim-atps=neutral
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Q5lnw6873z3bf7
	for <linux-erofs@lists.ozlabs.org>; Wed, 26 Apr 2023 14:12:36 +1000 (AEST)
Received: by mail-pg1-x535.google.com with SMTP id 41be03b00d2f7-5144a9c11c7so6677040a12.2
        for <linux-erofs@lists.ozlabs.org>; Tue, 25 Apr 2023 21:12:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682482354; x=1685074354;
        h=references:in-reply-to:references:in-reply-to:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=X1WEqmaMBFmHP4p7ngRgW+kux9X7VvJXBfEqvQ44Wow=;
        b=FkNan6seMjrCrf/+Y0Ne53q39DQC2hptzm8MXKt6vLlLuxLwlRNRrFs8YFuWKByRS5
         M/sOGNSLfOa+fFffafOUQbpHFS0qET5gxIGdgyOdiEkYC6o3QcUFEZHP5lmslR1DqJr6
         3cYklHnsd6GZ6g2uL9oLhcZV6gT1NXzKcDAMiuH5eZ0WL+xX/hAoyhxLBZBWACuQFCC5
         G18s+WD22+5jJCyrORTFE0lIQhE0QNJ0M8avMMIU5aA8ET3uLmcegPdswv8wvy0RxAKP
         CAdzT/QLHCoAAtACqUg73dXNGlInjK7+wI2M99AS12hM4rJwpItoZNt7jPF9P9LlVnCO
         zSnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682482354; x=1685074354;
        h=references:in-reply-to:references:in-reply-to:message-id:date
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=X1WEqmaMBFmHP4p7ngRgW+kux9X7VvJXBfEqvQ44Wow=;
        b=KTV6I+egKzj+3IqK7sscuEc+/Rz8XcjjkJ5wglZrFsb5Tqz8W1v0W/KYS6I+Oh+0Yx
         k+xvM0ufFjNiL0FA0sMKjqfsV+iL0acmyBz4Z4wosIZGw/BpqG8SK7K98JnGG9gMimhA
         Q7XRK9dxGsq3RcTqNu4MNUWuVDVyFiZP9AWU4n3GPJXXTqKmEUPaVbJblRvqrfaEwHWo
         +MyHpx3uMpK/J+io70pGs/vtkLRMsCmIDsDoRR6r4t20jW8ydtQlpHxuwq2lxtT/1Nu5
         mOV/agwTyHgFOYiqedlimDWZffiJpw3gPyY0M9NKTmS/7C4R7P52oREtoaqV8SHzu8Eh
         VwcA==
X-Gm-Message-State: AAQBX9e09FoIwdgcSsegpQQt9T+dOlCxBBEoeVIpJCo/d8YmQ8OzG7fK
	ZxxhGTiLOBgGn65mZa/Cg8c=
X-Google-Smtp-Source: AKy350bN3ku3tn8Ik9slYIdmFWsMuTaJMXfPG00UyeUr8poZu/xi8hZysYSE9D9VZJN7JMNKfEPt0A==
X-Received: by 2002:a17:902:dacc:b0:19e:ab29:1ec2 with SMTP id q12-20020a170902dacc00b0019eab291ec2mr26919278plx.65.1682482354637;
        Tue, 25 Apr 2023 21:12:34 -0700 (PDT)
Received: from localhost.localdomain ([156.236.96.165])
        by smtp.gmail.com with ESMTPSA id t5-20020a170902bc4500b001a68d613ad9sm8983193plz.132.2023.04.25.21.12.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Apr 2023 21:12:34 -0700 (PDT)
From: Yue Hu <zbestahu@gmail.com>
To: xiang@kernel.org,
	chao@kernel.org,
	linux-erofs@lists.ozlabs.org
Subject: [PATCH 2/2] erofs: replace global decompressors[] with stack memory
Date: Wed, 26 Apr 2023 12:10:27 +0800
Message-Id: <e9d0a320fb45d74f1f602dd77f685d1bae59325c.1682481589.git.huyue2@coolpad.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <a0c8b87b5c165750107bbaad6b014c02311b610d.1682481589.git.huyue2@coolpad.com>
References: <a0c8b87b5c165750107bbaad6b014c02311b610d.1682481589.git.huyue2@coolpad.com>
In-Reply-To: <a0c8b87b5c165750107bbaad6b014c02311b610d.1682481589.git.huyue2@coolpad.com>
References: <a0c8b87b5c165750107bbaad6b014c02311b610d.1682481589.git.huyue2@coolpad.com>
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
Cc: huyue2@coolpad.com, linux-kernel@vger.kernel.org, zhangwen@coolpad.com
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

From: Yue Hu <huyue2@coolpad.com>

Note that only z_erofs_decompress() is using the decompressors[], so no
need to keep it as global resource, just use local one instead.

Signed-off-by: Yue Hu <huyue2@coolpad.com>
---
 fs/erofs/decompressor.c | 33 ++++++++++++++++-----------------
 1 file changed, 16 insertions(+), 17 deletions(-)

diff --git a/fs/erofs/decompressor.c b/fs/erofs/decompressor.c
index f416ebd6f0dc..91d91bdd068f 100644
--- a/fs/erofs/decompressor.c
+++ b/fs/erofs/decompressor.c
@@ -368,25 +368,24 @@ struct z_erofs_decompressor {
 			  struct page **pagepool);
 };
 
-static struct z_erofs_decompressor decompressors[] = {
-	[Z_EROFS_COMPRESSION_SHIFTED] = {
-		.decompress = z_erofs_transform_plain,
-	},
-	[Z_EROFS_COMPRESSION_INTERLACED] = {
-		.decompress = z_erofs_transform_plain,
-	},
-	[Z_EROFS_COMPRESSION_LZ4] = {
-		.decompress = z_erofs_lz4_decompress,
-	},
-#ifdef CONFIG_EROFS_FS_ZIP_LZMA
-	[Z_EROFS_COMPRESSION_LZMA] = {
-		.decompress = z_erofs_lzma_decompress,
-	},
-#endif
-};
-
 int z_erofs_decompress(struct z_erofs_decompress_req *rq,
 		       struct page **pagepool)
 {
+	struct z_erofs_decompressor decompressors[] = {
+		[Z_EROFS_COMPRESSION_SHIFTED] = {
+			.decompress = z_erofs_transform_plain,
+		},
+		[Z_EROFS_COMPRESSION_INTERLACED] = {
+			.decompress = z_erofs_transform_plain,
+		},
+		[Z_EROFS_COMPRESSION_LZ4] = {
+			.decompress = z_erofs_lz4_decompress,
+		},
+#ifdef CONFIG_EROFS_FS_ZIP_LZMA
+		[Z_EROFS_COMPRESSION_LZMA] = {
+			.decompress = z_erofs_lzma_decompress,
+		},
+#endif
+	};
 	return decompressors[rq->alg].decompress(rq, pagepool);
 }
-- 
2.17.1

