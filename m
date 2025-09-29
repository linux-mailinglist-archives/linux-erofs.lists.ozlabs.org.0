Return-Path: <linux-erofs+bounces-1132-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id C726CBA95BA
	for <lists+linux-erofs@lfdr.de>; Mon, 29 Sep 2025 15:32:46 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4cb2Dq0HzSz304x;
	Mon, 29 Sep 2025 23:32:43 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a00:1450:4864:20::141"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1759152762;
	cv=none; b=mwv4jHtGUEwlDsPlVEDRK+KJicdriY9V6JuxG93jfud7TzkXEisUXi2GikSR3x71vBhb2hUjQqcTa4DeNYAnUnImuit4UBCV9hzjtEudVmxf52pdSEzpiwatSj+BxxFNIqhxBu8ZBZy2YOalUiSup77xpUGBKuL1Nts+SW6UIUPeKUvaD/c61f0EVHNllN9QxQPViXUeqO0R2m2VjDNvjX+u8Ptn9z1drhmpRkBrCAwwPqZSRbNoNHRdYXMG0x6V6R4PKnIEax0QStibyInEKTH1+NCJGL6nC/2sXN06Gm9FARIUtkjoL1Ia6zdvzfUTduN+NHoPPBFCFtFFk/0mlA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1759152762; c=relaxed/relaxed;
	bh=KGJjhOIsEilWBIsauSMMh3DuNE8KwjiCUcHodhYlLVM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=fjIyxcDW+ww874T8QOPFYANUX34MSIE7U/olPF5xFrAqFuQeyeSxgMdid6anPQcQ1nViWtde++GzdDrKjoUYhJQcG13XUaN3bndoGJvdAM3s/WQl7LS3PAlDwCzNMuT4vTz0FpDvh0Wx7/k2ae7NlV1MG+1Ev49O9DuB4/xrmxkqRlM/VAo1KKomCjJbr8LSXLNwbrHlGttlki4KxNE1c4f6ONF7bvxutg+GOSCowg5SC5nLd/55ovOBPJOfawisVdGVunLBhrds1MDhkM9Wjj7vKmdDAg1AXlWZb5/hQ9zfZrxO3nM2D2TIYw1EnboPPaQ+QvXEMCqkLX1bsewN5w==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=flant.com; dkim=pass (1024-bit key; unprotected) header.d=flant.com header.i=@flant.com header.a=rsa-sha256 header.s=google header.b=cvVw0Nsw; dkim-atps=neutral; spf=pass (client-ip=2a00:1450:4864:20::141; helo=mail-lf1-x141.google.com; envelope-from=ivan.mikheykin@flant.com; receiver=lists.ozlabs.org) smtp.mailfrom=flant.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=flant.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=flant.com header.i=@flant.com header.a=rsa-sha256 header.s=google header.b=cvVw0Nsw;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=flant.com (client-ip=2a00:1450:4864:20::141; helo=mail-lf1-x141.google.com; envelope-from=ivan.mikheykin@flant.com; receiver=lists.ozlabs.org)
Received: from mail-lf1-x141.google.com (mail-lf1-x141.google.com [IPv6:2a00:1450:4864:20::141])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4cb2Dl1qJhz2xgp
	for <linux-erofs@lists.ozlabs.org>; Mon, 29 Sep 2025 23:32:34 +1000 (AEST)
Received: by mail-lf1-x141.google.com with SMTP id 2adb3069b0e04-57a604fecb4so5622254e87.1
        for <linux-erofs@lists.ozlabs.org>; Mon, 29 Sep 2025 06:32:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=flant.com; s=google; t=1759152748; x=1759757548; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=KGJjhOIsEilWBIsauSMMh3DuNE8KwjiCUcHodhYlLVM=;
        b=cvVw0Nswp/sOPReNwsqXWWhDC3IxTjHoICb4TSpYywf57bYMkhrXGuGIwOEXw1ubWH
         M39bOLZ1fLqQwx2TNrngaKKGGZxgGhbzkSNM5DiNo3QPfj0vA++fz9l+p+9+IS3+ORAr
         7sbDgXTt4CKgyIayWL2qoz1qiFFAJmIUmu26c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759152748; x=1759757548;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KGJjhOIsEilWBIsauSMMh3DuNE8KwjiCUcHodhYlLVM=;
        b=ifPM8AsaBcMjTCc+WmHfQsmADA22w6YESHzfcDrgrXoV3+xf4eon3XioDyNgPmAV2t
         v169ec5wYK/0w47an7dSXGnG4g+rbA48X+Q3F5TMD9wpREhQytnyq4sqEEnlvMBDe0Ek
         XSsNvbExhAHiBhDpDAQwC4xB5g/RDITI6LqZO7Wo3udI93ip2tn/tYnAEblKAQDHeGd/
         cSqCSF3VEfU/CAcIsQkjtmRHJs0fXjdgUu0tOIfv+/66/LUPlN6/en5OBuFfQ65flUGR
         DTBlXXX9TRIyfiLhj2t0+3JhqEh6UGzl487soFzRYpIHXGqaTGQjhs+4qSLgr5DXuEBk
         drrA==
X-Gm-Message-State: AOJu0YxfAeesK3a2X7vJ69ijYSWPPjPqRqx/GZaSysTR1RWaDT7N5XTU
	cVInfzmVNI7jvXei+l3qzL8KmWLFEzX/7Tuzv+h/YlN8flcqs4j5ekjZdr4BCo+D61nH1XCQkze
	kSafEEWY7IvJDgUSh6Q3POrF07V0ZUhiRK+NBQSTU9R3MJ5hN1vV3ipJ1vgn5Hbb65uIjrE5AjV
	zMM7rH6wH7RJO4AQzsnjjRU8d81m2Z1M41s5Y2Eu1R22ovtgHrlmYABimZzJio
X-Gm-Gg: ASbGnctoesyO6KPpIqJnQtp571hb8RU8cZkGAyvptEmx2oYScGaDTlS5G65g6wsfKzF
	n9oerpoQTLvcdLXMx5/efamulD19ctJrPP2Y8pikJR5tUj6hAhyw4s+c+4x6CV3uOrNJnC/x4CB
	994sGrd/zHjiLrTiG445MgVzWmsd52HXhyK3n28PEl7DKl+1nnGrhT+3DNZuh9AqpouPobnL06V
	LWtIPkqmgC84J9qmc7uPo7Nti0zpAptwg5SWIiBCR9jx1i/sQk34ai3gVVpnIHOIQvvJ8PAxcEA
	v4MU4SrKSuooQ3qQh+V3d0hYWVfv19wYeUUQL0eWPjnmUUKbqE+ojHasu3PGGASraHL7Ss2UzFS
	+3n4uoK3X1em/NLd8ykexT3ApKLkjncmS0bkDRglQeCuDqA==
X-Google-Smtp-Source: AGHT+IH4WyOcG41P+p5Je6WUYDMc8YgAWI1XhQIk/c06tZ5EeA+PYoW1lZTPQ9e1GKyieTk2fNYJmg==
X-Received: by 2002:a05:6512:a8e:b0:577:1168:5e44 with SMTP id 2adb3069b0e04-582d3111855mr4909404e87.38.1759152747777;
        Mon, 29 Sep 2025 06:32:27 -0700 (PDT)
Received: from localhost ([91.188.191.17])
        by smtp.gmail.com with UTF8SMTPSA id 2adb3069b0e04-583134310bfsm4171816e87.26.2025.09.29.06.32.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 Sep 2025 06:32:27 -0700 (PDT)
From: Ivan Mikheykin <ivan.mikheykin@flant.com>
To: linux-erofs@lists.ozlabs.org
Cc: Ivan Mikheykin <ivan.mikheykin@flant.com>
Subject: [PATCH] erofs-utils: tar: support archives without end-of-archive entry
Date: Mon, 29 Sep 2025 16:32:22 +0300
Message-Id: <20250929133222.38815-1-ivan.mikheykin@flant.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
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
	DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
	autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org

Tar standard https://www.gnu.org/software/tar/manual/html_node/Standard.html
says that archive "terminated by an end-of-archive entry,
which consists of two 512 blocks of zero bytes".

Is also says:

"A reasonable system should write such end-of-file marker at the end
of an archive, but must not assume that such a block exists when
reading an archive. In particular, GNU tar does not treat missing
end-of-file marker as an error and silently ignores the fact."

It is rare for erofs to encounter such problem, as images are mostly
built with docker or buildah. But if you create image using tar library
in Golang directly uploading layers to registry, you'll get tar layers
without end-of-archive block. Running containers with such images will
trigger this error during extraction:

mkfs.erofs --tar=f --aufs --quiet -Enoinline_data test.erofs test-no-end.tar
<E> erofs: failed to read header block @ 42496
<E> erofs: 	Could not format the device : [Error 5] Input/output error

This patch fixes the problem by assuming that eof is equal to the end-of-archive.

Reproducible tar without end-of-archive (base64-encoded gzipped blob):
H4sICKVi2mgAA3Rlc3QtMTAtMi1ibG9ja3MudGFyAAtzDQr29PdjoCUwAAIzExMwbW5mCqYN
jQzANBgYGTEYmhqYmpqamRoaGTMYGBqaGJkyKBjQ1FVQUFpcklikoMCQkpmYll9ahFNdYkpu
Zh49HERfYKhnoWdowGVkYGSqa2Cua2jKNdAuGgX0BADwFwqsAAQAAA==

Signed-off-by: Ivan Mikheykin <ivan.mikheykin@flant.com>
---
 lib/tar.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/tar.c b/lib/tar.c
index 72c12ed..128f8b0 100644
--- a/lib/tar.c
+++ b/lib/tar.c
@@ -740,7 +740,7 @@ restart:
 	tar_offset = tar->offset;
 	ret = erofs_iostream_read(&tar->ios, (void **)&th, sizeof(*th));
 	if (ret != sizeof(*th)) {
-		if (tar->headeronly_mode || tar->ddtaridx_mode) {
+		if (tar->headeronly_mode || tar->ddtaridx_mode || tar->ios.feof) {
 			ret = 1;
 			goto out;
 		}
-- 
2.39.3 (Apple Git-146)


