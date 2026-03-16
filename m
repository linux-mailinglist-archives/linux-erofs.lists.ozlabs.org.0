Return-Path: <linux-erofs+bounces-2730-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UDaLDDi4t2mpUgEAu9opvQ
	(envelope-from <linux-erofs+bounces-2730-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Mon, 16 Mar 2026 08:58:48 +0100
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:21b9:f100::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 927FA295EB0
	for <lists+linux-erofs@lfdr.de>; Mon, 16 Mar 2026 08:58:47 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fZ6sv3w5bz2ygh;
	Mon, 16 Mar 2026 18:58:43 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::636"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1773647923;
	cv=none; b=C2Dc3H0imYahw5Imq7N3MaCCXp3UQJ5mQP/TY29fikR3K0QUk0nyqYia2F8ujg1zKvPZ4UCqZJ9/moJuhlU3M0BTMjU3dqwNgHeOUhulxqrX/k5B3XQTGgYYMctF+w5irlJFUCF2rFRXGsppsg6M7z/vAWwJ8MThyB9cUDatuiMINDaW04kMEJBg4XcHl0tIBVD2dHlobcfQzO5XSH2hISbzaQi7WlQB33l9Xh0f1TMUrTDilWvL+gb1/YJqVJeGhFADD8DRhDiQHGA/dVOyoXcbYjzw0H34ZrSel69MV2irAaoBHeHpa3KoUsbuPCGKqTBK6kiuXXwHZ0qmxqDjlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1773647923; c=relaxed/relaxed;
	bh=20DWZIEPhk3Wxt6WQ4zMMLXfwgjdpkbq2EWQvGpx6/8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GQ6g4Gr9LMIxvkOxTGdKms7eHzD5VFL60JWwkOwUk8Yy6tu0tsgD41fcdLMwe/TcvH31z3ckom2KKOEU2lmBar+kwgXQRcXJR0509W2Q/kfRYl/kg5cWh3ZcA+7oPGlDO5dEVyJduwT8/UATuGfGLC8hz4m4yoiNFCZ2EMYHi1o5GPMvWfDyTXIypDmRM92NKThL639vkotOJlJx5Kn9bOy3hBVyLc9QIpTrJNe21xFHevuO/BNkGGnojWy7JZGXFrlbSx3U+zHLJS3P152ELjBXzblZknXE4Sw/M3bg+Og+UG4xC0qeTVUap0AQ7YqnE0ysSt8/2h1OY8LkD5t1Jg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=NyWC8chY; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::636; helo=mail-pl1-x636.google.com; envelope-from=singhutkal015@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=NyWC8chY;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::636; helo=mail-pl1-x636.google.com; envelope-from=singhutkal015@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fZ6st5kPvz2xln
	for <linux-erofs@lists.ozlabs.org>; Mon, 16 Mar 2026 18:58:42 +1100 (AEDT)
Received: by mail-pl1-x636.google.com with SMTP id d9443c01a7336-2aecab39ad2so2736825ad.2
        for <linux-erofs@lists.ozlabs.org>; Mon, 16 Mar 2026 00:58:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773647921; x=1774252721; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=20DWZIEPhk3Wxt6WQ4zMMLXfwgjdpkbq2EWQvGpx6/8=;
        b=NyWC8chYMi6AV5Snnc4wN2CagjGTboXwLgGSL6rfbJrJ3LqDIx1YvbiFv0BGQ48rTu
         y8OlPQrUvMjm610x+Q5+0pMIqcEsE/L9r4ysN10AAhA4NFqnbUcLM7mjNqotl4agvuMJ
         gerpS9MxjBSKCWAPQ3l0KcRupyj3f0+EeGjDmxeu8JPkxunFu3hqmF8drk4o1rHzIEbu
         KPRh8uXwSz71LWjOvWN3zKmOX5Lxg2bGnqzFYyuVoa6/KDPOUcAl5jP5hS6l1cjZdACt
         sQqBU1RjNrcvjljfxwzEO4iIL+Z1+Ij9I9IoQ2frXl94JBVavd54Zg6HrN91tjIGC/ou
         PYQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773647921; x=1774252721;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=20DWZIEPhk3Wxt6WQ4zMMLXfwgjdpkbq2EWQvGpx6/8=;
        b=bU/Bbbnzzot/vL0Xx/rYqsVmlc0lS0p0wUSHFqRjgwoBUfdf+EvrmkcmLnh6XU6aIY
         XRryq+C0qHcMfVKDgl+JOwQgitE3PUi47s135fpp+EGW9JHcvZOatRZktDNI2KIh1uRP
         QVmp1S4m+PpGL7L7muYe3DQxu/WHgis+ag2JPNRpfp60lD28SMAaj4T7DktF1RaaDkDW
         edCHWwE3j4PN5oUBWJda6zLJD2ZwARwbdEXvNlEF6zPWKZEnm25diR3IbwZZF+9DEcQX
         KlMjqPCkKK5ot4QECErGEvdtEv1zQu7TUwIJK38MBjK3UwjsKl6i9oHlm6cvf7gDxRu7
         +oMQ==
X-Gm-Message-State: AOJu0Yw5DYgUpc3dSynDWq9VuBcR4Gk67M4sqNiOcCCrkYbOmHkw/Yds
	gAvXXBx54Y8JnwOnK7PvCdr1+d2FKQR+gGJgKQ/mSQ6CGL2VboxBi0qol7MXiuJz
X-Gm-Gg: ATEYQzxQ0t7oGyNpY4IC7iJ5pnr77ZwOQ4aKruwy/37WcrTp+4o5cUf4uqgYHilnAfH
	o2kRkvsCV6uw1SlwqRV2Bu2t4p+bXdPe0hdfmY0ChnENdLmTxYJQX8LSgmbvCUhiUj2ZpRxzOu5
	4JRtZ4ncd7npwgMmi6CIo2yKxINv1Po+tXaCEns9Hyym8eI5Cs5f1q3MsSQmp6YkZuDujheZqGE
	wr1puAKN5fJu707u2blbRVaYgkFBmV4oKz8WZ5BGBA7CsKkaEjhwkuCJzqguQFcT9F0Nfivut4l
	Php+PP98BDp5ByD2LFSu/J6UsSApJrm0GbgcWVl/VER+448GkofT8WspBwBQTqP5mIjFAYWfX+5
	BsCZOanhzTx6MDyfqQoUQYPz7NXOnxhd8aIZlpUSb4GqxOPxiRYuHHtiVZdWG4Yg+oK5BMBSDBy
	Danb+wDvnSiuuYD4KD0w+JyrEKEshEWwOgYCrUzFAItwD+dMo0lBhQk8Nm2wDawDmw3ZBBSM7uJ
	OqJxvU6hjunKkGhizP24yTsqR4yjWbZfm4i+wJ9s3Iv3cSm
X-Received: by 2002:a17:903:18d2:b0:2ae:cacf:fc57 with SMTP id d9443c01a7336-2aecad0132amr46656195ad.4.1773647920588;
        Mon, 16 Mar 2026 00:58:40 -0700 (PDT)
Received: from DESKTOP-PU4IGQQ.localdomain ([117.203.246.41])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2aece7ed753sm124225025ad.45.2026.03.16.00.58.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Mar 2026 00:58:40 -0700 (PDT)
From: Utkal Singh <singhutkal015@gmail.com>
To: linux-erofs@lists.ozlabs.org
Cc: xiang@kernel.org,
	yifan.yfzhao@foxmail.com,
	Utkal Singh <singhutkal015@gmail.com>
Subject: [PATCH v3 2/2] erofs-utils: lib/tar: reject negative size= value in PAX header
Date: Mon, 16 Mar 2026 07:58:31 +0000
Message-ID: <20260316075831.35495-3-singhutkal015@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260316075831.35495-1-singhutkal015@gmail.com>
References: <20260316075831.35495-1-singhutkal015@gmail.com>
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
Content-Transfer-Encoding: quoted-printable
X-Spam-Flag: YES
X-Spam-Status: Yes, score=3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS
	autolearn=disabled version=4.0.1
X-Spam-Report: 
	* -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at https://www.dnswl.org/, no
	*      trust
	*      [2607:f8b0:4864:20:0:0:0:636 listed in]
	[list.dnswl.org]
	*  3.6 RCVD_IN_SBL_CSS RBL: Received via a relay in Spamhaus SBL-CSS
	*      [117.203.246.41 listed in zen.spamhaus.org]
	* -0.0 SPF_PASS SPF: sender matches SPF record
	*  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
	* -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
	*      envelope-from domain
	*  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
	*      valid
	* -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from author's
	*       domain
	* -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
	*  0.2 FREEMAIL_ENVFROM_END_DIGIT Envelope-from freemail username ends in
	*      digit
	*      [singhutkal015(at)gmail.com]
	*  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail provider
	*      [singhutkal015(at)gmail.com]
X-Spam-Level: ***
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org
X-Spamd-Result: default: False [4.30 / 15.00];
	SPAM_FLAG(5.00)[];
	ARC_ALLOW(-1.00)[lists.ozlabs.org:s=201707:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2404:9400:21b9:f100::1:c];
	MAILLIST(-0.19)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-2730-lists,linux-erofs=lfdr.de];
	GREYLIST(0.00)[pass,meta];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	FREEMAIL_FROM(0.00)[gmail.com];
	PREVIOUSLY_DELIVERED(0.00)[linux-erofs@lists.ozlabs.org];
	FROM_NEQ_ENVFROM(0.00)[singhutkal015@gmail.com,linux-erofs@lists.ozlabs.org];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,foxmail.com,gmail.com];
	TAGGED_RCPT(0.00)[linux-erofs];
	ASN(0.00)[asn:133159, ipnet:2404:9400:2000::/36, country:AU];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	NEURAL_SPAM(0.00)[0.227];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lists.ozlabs.org:helo,lists.ozlabs.org:rdns]
X-Rspamd-Queue-Id: 927FA295EB0
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The PAX extended header size=3D field is parsed into a signed long
long but no check is made for negative values before assigning to
eh->st.st_size. A crafted PAX header with size=3D-1 passes the
existing format check, resulting in a negative file size that can
cause incorrect memory allocation and heap corruption in subsequent
read or seek operations.

Add an explicit check to reject negative size=3D values with -EINVAL.

Reproducer (base64-encoded minimal crafted tar):
  echo "Li9QYXhIZWFkZXJzL3Rlc3QAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA=
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAADAwMDA2Nj=
YAMDAwMDAwMAAwMDAwMDAwADAwMDAwMDAwMDEzADAwMDAwMDAwMDAwADAxMTA3NgAgeAAAAAAAA=
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA=
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAB1c3RhciAgAAAAAAAAAAAAAAA=
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA=
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA=
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA=
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA=
AAAAAAAAAAAAAAAAxMyBzaXplPS0xCgAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA=
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA=
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA=
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA=
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA=
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA=
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA=
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA=
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA=
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA=
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA=
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA=
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA=
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA=
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA=
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA=
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA=
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA=
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA=
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA=
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA=
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA=
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA=
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA=
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA=
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA=
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA=
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA=3D" | base64 -d > crafted-negative-=
size.tar
  mkfs.erofs --tar=3Df out.img < crafted-negative-size.tar

Signed-off-by: Utkal Singh <singhutkal015@gmail.com>
---
 lib/tar.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/lib/tar.c b/lib/tar.c
index be86984..6fa2cda 100644
--- a/lib/tar.c
+++ b/lib/tar.c
@@ -546,6 +546,11 @@ int tarerofs_parse_pax_header(struct erofs_iostream *i=
os,
 					ret =3D -EIO;
 					goto out;
 				}
+				if (lln < 0) {
+					erofs_err("invalid negative size=3D in PAX header");
+					ret =3D -EINVAL;
+					goto out;
+				}
 				eh->st.st_size =3D lln;
 				eh->use_size =3D true;
 			} else if (!strncmp(kv, "uid=3D", sizeof("uid=3D") - 1)) {
--=20
2.43.0


