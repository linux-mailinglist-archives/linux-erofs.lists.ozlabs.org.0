Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CB784586B8
	for <lists+linux-erofs@lfdr.de>; Sun, 21 Nov 2021 23:23:44 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Hy4gK5mm3z2ymk
	for <lists+linux-erofs@lfdr.de>; Mon, 22 Nov 2021 09:23:41 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20210112 header.b=B5CBrHOI;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::82a;
 helo=mail-qt1-x82a.google.com; envelope-from=fedora.dm0@gmail.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20210112 header.b=B5CBrHOI; dkim-atps=neutral
Received: from mail-qt1-x82a.google.com (mail-qt1-x82a.google.com
 [IPv6:2607:f8b0:4864:20::82a])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4Hy4gB3tJFz2xtF
 for <linux-erofs@lists.ozlabs.org>; Mon, 22 Nov 2021 09:23:32 +1100 (AEDT)
Received: by mail-qt1-x82a.google.com with SMTP id n15so14927207qta.0
 for <linux-erofs@lists.ozlabs.org>; Sun, 21 Nov 2021 14:23:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=from:to:cc:subject:date:message-id:mime-version;
 bh=QovVwcCtwBCoANdiAnCc8bYM5vSj6ZoK6wNZlIO0e8E=;
 b=B5CBrHOIKwYR7yrdjVDrVltH3F+ys5a62kzYdz7poAZoRWyFVSHhZWUw4RdFqq98KL
 ETrelcRTFQ6dcmAm1qOco0fkwmi2OZ9YTPjtS9jfenif60MikKyiur1MXCb3LP9tV6Ke
 +zjBiHQOgBtsnyj7hAAAbQQG0FwY+jkQxPKAaoC70vr6tMI4eQqU7Ec4K4fDykOHqyyd
 LbDRUEd9eZVOVrM5xwu/Pmzi1ntfxKgYSUBnJtNHTe4qM9GUfNFQqQQo7+tmVhg4Gjfx
 a/iNTLGC3qNjqJWeD6RYOt5l+3xNa0KhVPH56Tjvji+iZWx3LbRRgkuQi4tWMJIBmUn0
 1V3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version;
 bh=QovVwcCtwBCoANdiAnCc8bYM5vSj6ZoK6wNZlIO0e8E=;
 b=OJWLNim/XKf7hUD9JfG2VYgUjlw1Thgyus960DJKAMqUTEAphR9aPfiaobFpM2O43v
 0EGov2p/I2rBloR+i+cF9iJJEeiBGO2R6vtxnjhPsaXqU4Jbte+pn+cUWXR052C1xT2V
 qY9CRDYz72hSLijOkKPg5TwfhPqfjidU4JyWdsautw7Gj73zO8/df3FyhUy3ejeW2oUH
 oEuNc9zkyG0NVM3yM5zpkaio0t0QfIoS23N+OFc+14fY/uczrSow6QaN2/YW/T0RK6f4
 S6rIn+MWo3R1lwvSMe87gp5ebEHF04I3zHvPfoN/483ZatCEOHLHiEqsVstAk7ypRsbT
 I26Q==
X-Gm-Message-State: AOAM533VTiinW953RDjlSokUbjUs96hCubcphGvQr6OejmnqeEhPQrwe
 X7pXFA5/biIruY0BDVgKRT8=
X-Google-Smtp-Source: ABdhPJw6900c04bFVKMJgpjdH3M3lG2n0xZXtAbsxPGpCETZSzBAOQQ9w+sjJbOal0qTb/Z40AZiwA==
X-Received: by 2002:a05:622a:30e:: with SMTP id
 q14mr26814704qtw.71.1637533408007; 
 Sun, 21 Nov 2021 14:23:28 -0800 (PST)
Received: from callisto (c-73-175-137-55.hsd1.pa.comcast.net. [73.175.137.55])
 by smtp.gmail.com with ESMTPSA id
 w19sm3388381qkw.49.2021.11.21.14.23.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 21 Nov 2021 14:23:27 -0800 (PST)
From: David Michael <fedora.dm0@gmail.com>
To: linux-erofs@lists.ozlabs.org
Subject: [PATCH] erofs-utils: dump: fix format errors on some architectures
Date: Sun, 21 Nov 2021 17:23:26 -0500
Message-ID: <87tug5jggx.fsf@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
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
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

This applies the same type casting to nid values as is done in the
other formatting function calls to avoid this error:

    In file included from main.c:11:
    main.c: In function 'erofs_checkdirent':
    ../include/erofs/print.h:68:25: error: format '%llu' expects argument of type 'long long unsigned int', but argument 3 has type '__le64' {aka 'long unsigned int'} [-Werror=format=]
       68 |                         "<E> " PR_FMT_FUNC_LINE(fmt),   \
          |                         ^~~~~~
    main.c:264:17: note: in expansion of macro 'erofs_err'
      264 |                 erofs_err("invalid file type %llu", de->nid);
          |                 ^~~~~~~~~
    main.c: In function 'erofs_read_dirent':
    ../include/erofs/print.h:68:25: error: format '%llu' expects argument of type 'long long unsigned int', but argument 3 has type '__le64' {aka 'long unsigned int'} [-Werror=format=]
       68 |                         "<E> " PR_FMT_FUNC_LINE(fmt),   \
          |                         ^~~~~~
    main.c:303:25: note: in expansion of macro 'erofs_err'
      303 |                         erofs_err("parse dir nid %llu error occurred\n",
          |                         ^~~~~~~~~
    cc1: all warnings being treated as errors

Signed-off-by: David Michael <fedora.dm0@gmail.com>
---

Hi,

I hit this build failure on powerpc64le when trying the 1.4 release.
Can something like this be applied to get around it?

Thanks.

David

 dump/main.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/dump/main.c b/dump/main.c
index b7560ec..6f5b9e7 100644
--- a/dump/main.c
+++ b/dump/main.c
@@ -261,7 +261,7 @@ static inline int erofs_checkdirent(struct erofs_dirent *de,
 		return -EFSCORRUPTED;
 	}
 	if (de->file_type >= EROFS_FT_MAX) {
-		erofs_err("invalid file type %llu", de->nid);
+		erofs_err("invalid file type %llu", de->nid | 0ULL);
 		return -EFSCORRUPTED;
 	}
 	return dname_len;
@@ -301,7 +301,7 @@ static int erofs_read_dirent(struct erofs_dirent *de,
 		err = erofs_read_dir(de->nid, nid);
 		if (err) {
 			erofs_err("parse dir nid %llu error occurred\n",
-					de->nid);
+					de->nid | 0ULL);
 			return err;
 		}
 	}
-- 
2.31.1

