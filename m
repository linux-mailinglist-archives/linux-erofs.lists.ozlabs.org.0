Return-Path: <linux-erofs+bounces-1150-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 20D03BB155E
	for <lists+linux-erofs@lfdr.de>; Wed, 01 Oct 2025 19:14:38 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4ccM3v1bcxz3cf7;
	Thu,  2 Oct 2025 03:14:35 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a00:1450:4864:20::143"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1759338875;
	cv=none; b=o2hc7bNINasl2HYvO9gCr3TSS4veIaf81IT8LbKn15Qpawj7TYX5tcSPzcWuiZZwLLC5MzGcCEdghDNuXBjlia4jLgxncy7ODXJwhx22MhPuXQGzB6Hkw8f8/flX18PBbfn+CZZ+lb4Ye7WKYYbI28+TXNjUE5RykWrGjFCf9tnJ1ulZwGQyP5HZAo75BFYlhMXiy9lkIe8q0P52uf9KKWVlGjiAgEi7k4vEDn9z6L8hdFOvrbF48ZgiV0ROv7MEdP/ANm1PAHDZ1e66v/jKtSce83aCnGMSMNmyOnGOstZiNXmU1OpqOpOaYPo2bqZpKs1SmAUrxLSUKOd0Oj0kcA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1759338875; c=relaxed/relaxed;
	bh=0tqiwXOlk9gZ/djQvuPBeC6RKO5r69FZMAmb557xtOQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ADeMAyfAXIbmQS8WLJcrTxPPT+WqRpoyVITlwLdNcCK7FFM4M8WzKatpenY3o9q8UKffgbZ4RTb9YAoDTrli8VHYqV+9rZPUx7992jwtsxb32VeK7upyzlt3hmqzxclXqam2hJXJFEzBoBWT7+WDfuR29wIEEcNXnnu6J6HHpSRMpMQvfiEzned6liTOjGNheYHXo2AH0ShWxODTi3D93ZEVFrJDszCVFn7qmxzqvX2xxPqxXRkYuZ4emu4AmvqWpat7CSy3Rkm6TvyIEia57IXvBh0vQhcVFNRA/YXUwXXM4gmhKUs72FOGUmOmyO/X2eC9cD6AY/l8feyMduoX6g==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=flant.com; dkim=pass (1024-bit key; unprotected) header.d=flant.com header.i=@flant.com header.a=rsa-sha256 header.s=google header.b=G1q4AMvO; dkim-atps=neutral; spf=pass (client-ip=2a00:1450:4864:20::143; helo=mail-lf1-x143.google.com; envelope-from=ivan.mikheykin@flant.com; receiver=lists.ozlabs.org) smtp.mailfrom=flant.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=flant.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=flant.com header.i=@flant.com header.a=rsa-sha256 header.s=google header.b=G1q4AMvO;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=flant.com (client-ip=2a00:1450:4864:20::143; helo=mail-lf1-x143.google.com; envelope-from=ivan.mikheykin@flant.com; receiver=lists.ozlabs.org)
Received: from mail-lf1-x143.google.com (mail-lf1-x143.google.com [IPv6:2a00:1450:4864:20::143])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4ccM3q0R3Mz3cdn
	for <linux-erofs@lists.ozlabs.org>; Thu,  2 Oct 2025 03:14:26 +1000 (AEST)
Received: by mail-lf1-x143.google.com with SMTP id 2adb3069b0e04-57dfd0b6cd7so85410e87.0
        for <linux-erofs@lists.ozlabs.org>; Wed, 01 Oct 2025 10:14:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=flant.com; s=google; t=1759338861; x=1759943661; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0tqiwXOlk9gZ/djQvuPBeC6RKO5r69FZMAmb557xtOQ=;
        b=G1q4AMvO41ggjqy9sJCoj3MNChggkm3K1kYbohO7nrmil6+jbW8RB6CI4953qKl6LX
         ZlkacXAdcHzV7weHO3WkE4Yl1Y/V2cJlculd8guvuPGuWWMdZy2X/rqea2xrGwtZ72sQ
         7Iyz5O9RlwNTZTHifwoXPC+T8bDLp1op3IS04=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759338861; x=1759943661;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0tqiwXOlk9gZ/djQvuPBeC6RKO5r69FZMAmb557xtOQ=;
        b=oA7+E3daPHYJsxvaFJYJU4W88kHNI96EokD6j6/Kwj75vvyhVNxChjXbP8bdSj77MG
         Xuik7JYMEt1DRzn1O8zcLVZl6VgrEvTNn39J8uiqVahvpoCE4tu72gjVDxIgvMRIXNlf
         JkFv2EMOdR5GJxWP/VW7JuqnHlg7xuh+1Oh4G51oM3fn9qMAEdL8PHZvIz8Z7fq1SUPX
         VIOggCxqFWz5TTM9h2VBya+esTuH8G/Reoqh+Rsg6nklL3XWdwsulSloShdXi1lwWg+O
         v8weBCINohHSPH8YohmD4SWe4XCIcwaOOZ1Zw/WGZGf0Va5DUDYo7a9bjzt5cQ+GCt2K
         NuFw==
X-Gm-Message-State: AOJu0Yz+qyrrWxNXAJUQ6LZO08O8tygLYk9BU0IssHQ36A8ghNBELkTP
	UrP2Lj2kc99p6Jnsm9l2l+yB3Jc8qqNVmUOKVU7MhR0nrGA+iXFQt1qAjv11SwX4Ve8=
X-Gm-Gg: ASbGncvVeHjGyZacuQBcMupd9U3brWCJsyXy95hW60RSICREncblA6IEm68VWtRy6b3
	u30CvAOgWerodM/zmjjn+qoNmYA0B1NxYgLIRy8eQLbu/f+6CS2L8y1h5MeNeMZbMX8I+Hy4RER
	8pZ6sW9cefYd+AIgOSd1gjvBdkrbu2aC4Kmty42z490pNeKl/nEn0vu6nZlyg0v4tG8itJgcINN
	RZKpiCugzCubzTKoMYpAFu31slZSDjzhClF5zu9+11JR/1TxdMt6xDLtUjjWAISjqpPkssJsE5l
	LOnGjmuWxE4bYsHlk74pU0KfRJKBBuxHRm15PDAE+cEX6OVZHJbD3mWWAZLWsy7NZK0mloI7+jX
	ndZxJ7vaE8irRzQkXOzFsqbzj8kqazShFTGezpOyHmfzHAq3dsuSAc6gw0rS+sjKoSskrrD9IOd
	+++rnjjTWUJXum2mbori+X9b+3RazEeBbeF0c4HdxIPlQ=
X-Google-Smtp-Source: AGHT+IE6F5F6CwvyMMriW9dt8WXysOHawm+j1RZeO7dCpZicvaqnrYqu6uWTaahah5v4WbN+2KTJgQ==
X-Received: by 2002:a05:6512:12c9:b0:55f:4512:71f3 with SMTP id 2adb3069b0e04-58af9f4093emr1364308e87.33.1759338861168;
        Wed, 01 Oct 2025 10:14:21 -0700 (PDT)
Received: from localhost (109-252-69-109.nat.spd-mgts.ru. [109.252.69.109])
        by smtp.gmail.com with UTF8SMTPSA id 2adb3069b0e04-58b0119e61asm31910e87.95.2025.10.01.10.14.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Oct 2025 10:14:20 -0700 (PDT)
From: Ivan Mikheykin <ivan.mikheykin@flant.com>
To: Gao Xiang <xiang@kernel.org>
Cc: linux-erofs@lists.ozlabs.org,
	Ivan Mikheykin <ivan.mikheykin@flant.com>
Subject: [PATCH v2] erofs-utils: tar: support archives without end-of-archive entry
Date: Wed,  1 Oct 2025 20:13:41 +0300
Message-Id: <20251001171341.87845-1-ivan.mikheykin@flant.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
In-Reply-To: <20250929133222.38815-1-ivan.mikheykin@flant.com>
References: <20250929133222.38815-1-ivan.mikheykin@flant.com>
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

Also, add warning about non-conformant tar layers:

mkfs.erofs --tar=f --aufs -Enoinline_data test.erofs test-no-end.tar
mkfs.erofs 1.8.10-g0a2bc574-dirty
<W> erofs: unexpected end of file @ 1024 (may be non-standard tar without end of archive zeros)
Build completed.
...

Signed-off-by: Ivan Mikheykin <ivan.mikheykin@flant.com>
---
 lib/tar.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/lib/tar.c b/lib/tar.c
index 100efb3..46a9c92 100644
--- a/lib/tar.c
+++ b/lib/tar.c
@@ -725,6 +725,11 @@ restart:
 	tar_offset = tar->offset;
 	ret = erofs_iostream_read(&tar->ios, (void **)&th, sizeof(*th));
 	if (ret != sizeof(*th)) {
+		if (tar->ios.feof) {
+			erofs_warn("unexpected end of file @ %llu (may be non-standard tar without end of archive zeros)", tar_offset);
+			ret = 1;
+			goto out;
+		}
 		if (tar->headeronly_mode || tar->ddtaridx_mode) {
 			ret = 1;
 			goto out;
-- 
2.39.3 (Apple Git-146)


