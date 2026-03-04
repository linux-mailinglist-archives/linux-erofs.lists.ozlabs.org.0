Return-Path: <linux-erofs+bounces-2496-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8KPmFol6qGmHuwAAu9opvQ
	(envelope-from <linux-erofs+bounces-2496-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Wed, 04 Mar 2026 19:31:37 +0100
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 71A19206616
	for <lists+linux-erofs@lfdr.de>; Wed, 04 Mar 2026 19:31:35 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fR1Tc4qyXz3btf;
	Thu, 05 Mar 2026 05:31:32 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a00:1450:4864:20::22b" arc.chain=google.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1772649092;
	cv=pass; b=bG7I9hAyjtW1d8cy0UkIjkGqFvyMPR8OUT16xXX96C2rf4Vw3tZvgMrFLnzx4hPEoxRrSYhLfNV31qc4G4FnM9wYYNBMuf/42kUDhy3fzs1B4V1jo5SGkQAD3Y4br0za2BQV6kGyp8EaiCH6pq4uqYEPcdlcAY0OlwtflvH82dP5TODprTcN6IXuGaVFJDEUGfm7n2N0xoMEEFefAtrTnfinafgL3wOzu7+NGEU+ySP691kXQHFC5kIofULFlIlhs5m8s34anjUa/NtGHOTlvSX7P7CaOsVv2y74sx1ufTbDDgKYZL2Bzrbr77ipK1DY2HFe31r8m7Ohw1iPIt9ebQ==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1772649092; c=relaxed/relaxed;
	bh=olIp04NznqnfZtFzvdSDWRMySDmvwOupWPuAwawmqSc=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=Q9iS55gR/mepxuNGnSapgpEa3WFjeUz8jholXpzdpSlY3J/Zwod8vnm61GHa/l+3ArRtgW4E0vEVdFyH1FJUtkXONJMEViY+cXGo8ABu2Xx89Z+i9JlLlK8/3pXlMwry9rdeDL+I12GI4CmQSc4kfsXXuq+A1ZwtsCdCDaHSdWua+LblLxAeW9nF1DPRpC7itjZ8OS8QDfA7Y6l5yNnWetlpeHgciyQovabdd88Fp9yzyOHgfeyagGOVwhwLKsOmMaCr4XUQ8yEodJbxH/6SL1zsaIVx4ScT99fmJetYTDG6sIHk4/7lwJ3Rj8Et/65VGDccM3v3/tpQl5EGnwqGkQ==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=F9bEB1VJ; dkim-atps=neutral; spf=pass (client-ip=2a00:1450:4864:20::22b; helo=mail-lj1-x22b.google.com; envelope-from=aayushmaan.chakraborty@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=F9bEB1VJ;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2a00:1450:4864:20::22b; helo=mail-lj1-x22b.google.com; envelope-from=aayushmaan.chakraborty@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fR1TZ3JFCz30hq
	for <linux-erofs@lists.ozlabs.org>; Thu, 05 Mar 2026 05:31:29 +1100 (AEDT)
Received: by mail-lj1-x22b.google.com with SMTP id 38308e7fff4ca-38a2544b52bso35783371fa.3
        for <linux-erofs@lists.ozlabs.org>; Wed, 04 Mar 2026 10:31:29 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772649086; cv=none;
        d=google.com; s=arc-20240605;
        b=JB7DXJQE/k3G58kXSdJmmVCU1evTo+sTQwb2FjeSuYbXAlH4ktYErrRJWu3iYX6qBK
         PLiEjQQ+R6E+OpaApK8CkQAh7r5PvVH7DvqgPrVZ1X5VfeQfxf8IkCzooKHvywfOuH8Z
         xuVXHgJQyYfxIKM7VlAgsMbcRxuQ00URt8tNIc1KTw65uXOeD1qaxx90vhLlvwELXlhP
         A6Sc4rJ05eDp3TlLxh6uBEGsGKBbLWJi6XFbw0dFOJ4yz0uhY2ZbzqSGRhUcydlfBgqD
         wfegkKBfOKRnwvKyLWQzkoxoSJ8EMx3bc46tG3D5OYC/Wf4wF6dWSP3TkJtudzD/jcRA
         S0jA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:dkim-signature;
        bh=olIp04NznqnfZtFzvdSDWRMySDmvwOupWPuAwawmqSc=;
        fh=wOhGMmq2KH+KOElLlPuS8ws9o9ArjDb4wH58JVHh4Vg=;
        b=Cr969k1ZjVoLZl0vY5AvNhdcf2Mdvg2jbLDa2x5d6EZdaZE85gjQNRvFoT4DucOr/o
         81UX5e5d8WDab2MlF3W5aXHgfmraSkoxhvLA49peruyIadtN/bY9j64xTkhz7zTrBalK
         f++c8fSJAtUDhoa9eUUd4ItXUyM7r33aGaw5YlG2OUwnntRJwdRUBRWBg4r8VGqx0WFU
         wuZVmTwhJLU+YRuUioSeiiARm6rCrCmnBbAQaam1+7He31xO5cG7311qe4xCWXojvwET
         eILnvoSVy31wViOopMXQx65JJ1WesgL76QUS+yAw5dLk9eTw1LojMqTf0JNuxw8ZlwzE
         3zkg==;
        darn=lists.ozlabs.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772649086; x=1773253886; darn=lists.ozlabs.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=olIp04NznqnfZtFzvdSDWRMySDmvwOupWPuAwawmqSc=;
        b=F9bEB1VJNs6ZwvrprWBRqIudDw9/s4lLMGt0+eS0co89T20lPx8b1YoV9E1vxD57SW
         hIu/sn20rmB+WF9EP453C3oqt0DycmX43fNvTNsNWl3G6Agh8MiQuJkGlHXpoPKmZ47n
         8ZsCKJAMfHYIQc+ZNapC9h/bDY4RclJslqsP2tHenxHJ+7ykMa/lgs9Gh62yvRMi+CKX
         31v5jOGK8XAix4TVUl6n0ot48m8AqEnQ+hzWBVNdh1Sx7zg0Z9UyYnEz7Kj5r1iMz5wF
         suJ/rPfKw5zIesvxlTiVEN6zMxxrklOnzLVMdEYfIxHBwJOsw3PaDB2HCCFnJnfKGTnV
         kvsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772649086; x=1773253886;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=olIp04NznqnfZtFzvdSDWRMySDmvwOupWPuAwawmqSc=;
        b=mTONJOabFF8qUhFSLgXkXsfI3IIQHt9xPv8T7/WoyhWOBYYxrHGMZypqXEC7DnSudV
         5UtYQS/kUGRu+3a1wJCgvo/DZzPJDA1C/U4sqyTxLKe68yL2Qxf/DXGsgqUbHfrGkNzv
         LhJ4E0q+UL2OXawyjpLIypEElAJWc0pTzs70OsYsL5e5+nAl6WhcOfj/0hBLe9xIy+H5
         59ADHTdwpZbfEcWQU11CNvepvHwPkU9oB8TG4NHdGU+xOMZJGmHeYm5JalN4g/K9GBtt
         9R78Y6Es2FUV5w+SkpTQmbvKQkF6v19JezKfFWJTWBSbmvV6ctv7GE4HMdRWsExXmjMl
         AK9w==
X-Gm-Message-State: AOJu0Ywx/T/VAxhy2urB4o0eawwMk26tqehblj+yYFlMQS1a/h10JInm
	RbD4B3YJo7NUg9oyLCve+RaSanaxPd6E0c3SVHn92vgSPdYqTfPQuvZ58hll6/x5mR0JAkl7jiK
	zfunp80KyrMAWTZloGd9S937oeV/oOmYSqJJIBbE=
X-Gm-Gg: ATEYQzy1t7Ce0G6yi97np1bJS0eONlAdAuazpv3syU5tlUHjZRavanfyFmF7nZuhr9u
	7WVopEd2Lkjh+cGxyOOQwA6Hp3GBF5AZb8W+ehVf+U7T6sF6SQAe0p/LgpF9le2I582WoTfwnOy
	P5Naj/oJgN3NDGpIRzbl62+xtp6tAxwdZKkDocUNmrG5mQaHjQPlN21WhOHqAPZTQ70QyCeaLi/
	Sn7AweU/d1fehIIm3KPsiqSr3DsFG3x6NPB3SajERinVdZwxOUqsHhYSfQkoublTC+MduALPkU1
	x7tOwNM=
X-Received: by 2002:a2e:9817:0:b0:38a:27b1:4e60 with SMTP id
 38308e7fff4ca-38a2c7aec85mr17950671fa.27.1772649085940; Wed, 04 Mar 2026
 10:31:25 -0800 (PST)
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
From: Aayushmaan Chakraborty <aayushmaan.chakraborty@gmail.com>
Date: Thu, 5 Mar 2026 00:01:12 +0530
X-Gm-Features: AaiRm52iENV1ndDVnQUyj310DJtd7dZ9mHyqM7w7qrfWIgDexWhH8T5Qi0KFqwc
Message-ID: <CABCXVckQ8XbcsZJXE7OPyut2Qj5At_P1_j+ix6cxDymDT1f3Pw@mail.gmail.com>
Subject: [PATCH] README: Add Quick Start section with beginner-friendly build,
 test, verify, and mount guide
To: linux-erofs@lists.ozlabs.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=0.8 required=3.0 tests=ARC_SIGNED,ARC_VALID,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_GMAIL_RCVD,
	FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
	autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org
X-Rspamd-Queue-Id: 71A19206616
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.20 / 15.00];
	ARC_ALLOW(-1.00)[lists.ozlabs.org:s=201707:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:112.213.38.117];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.19)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-2496-lists,linux-erofs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_ONE(0.00)[1];
	FREEMAIL_FROM(0.00)[gmail.com];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:133159, ipnet:112.213.32.0/21, country:AU];
	MISSING_XM_UA(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[linux-erofs@lists.ozlabs.org];
	TO_DN_NONE(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[aayushmaanchakraborty@gmail.com,linux-erofs@lists.ozlabs.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.945];
	TAGGED_RCPT(0.00)[linux-erofs];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,lists.ozlabs.org:rdns,lists.ozlabs.org:helo]
X-Rspamd-Action: no action

Hi EROFS maintainers,

As a prospective GSoC 2026 contributor interested in low-level
filesystem work, here's a small documentation improvement to
README.md:

- Added a prominent Quick Start section early for better onboarding
- Full beginner workflow: build =E2=86=92 mkfs.erofs =E2=86=92 fsck =E2=86=
=92 erofsfuse mount =E2=86=92 cleanup
- Compressed example + multithreading note
- Shields badges and upstream/community links

Patch attached (generated from my fork:
https://github.com/Aayushmaan-24/erofs-utils/tree/feature/readme-quick-star=
t).

All commands verified locally. Happy to revise or split changes.

Thanks for considering!
Aayushmaan
GitHub: Aayushmaan-24

signed off by: Aayushmaan Chakraborty <aayushmaan.chakraborty@gmail.com>


From b50fd7d848bb3ad05080d3ded862d0bc74254b65 Mon Sep 17 00:00:00 2001
From: Aayushmaan <aayushmaan.chakraborty@gmail.com>
Date: Sat, 28 Feb 2026 14:50:05 +0530
Subject: [PATCH] README: Add Quick Start section with beginner-friendly bui=
ld,
 test, verify, and mount guide

- Inserted early for better onboarding
- Debian/Ubuntu deps (Crostini tested)
- End-to-end flow incl. fsck success hint and compressed example
- Shields badges + upstream/community links
- No changes to existing technical sections
---
 README | 67 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 67 insertions(+)

diff --git a/README b/README
index 1ca376f..68a00b1 100644
--- a/README
+++ b/README
@@ -1,6 +1,9 @@
 erofs-utils
 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

+[![Last Commit](https://img.shields.io/github/last-commit/erofs/erofs-util=
s/dev)](https://github.com/erofs/erofs-utils/commits/dev)
+[![License](https://img.shields.io/badge/License-GPL--2.0%20or%20Apache--2=
.0-blue)](COPYING)
+
 Userspace tools for EROFS filesystem, currently including:

   mkfs.erofs    filesystem formatter
@@ -11,6 +14,7 @@ Userspace tools for EROFS filesystem, currently including=
:
                 as extractor


+
 EROFS filesystem overview
 -------------------------

@@ -49,6 +53,61 @@ For more details on how to build erofs-utils, see
`docs/INSTALL.md`.
 For more details about filesystem performance, see
 `docs/PERFORMANCE.md`.

+Quick Start: Build, Create, Mount, and Verify an EROFS Image
+------------------------------------------------------------
+
+1. Install dependencies:
+   ```bash
+   sudo apt update
+   sudo apt install -y autoconf automake libtool pkg-config \
+       libfuse-dev liblz4-dev liblzma-dev libzstd-dev uuid-dev zlib1g-dev
+   ```
+
+2. Clone and build:
+   ```bash
+   git clone https://github.com/erofs/erofs-utils.git
+   cd erofs-utils
+   ./autogen.sh
+   ./configure --enable-lz4 --enable-lzma --enable-fuse
--with-libzstd [--enable-multithreading]
+   make -j$(nproc)
+   ```
+
+3. Create a simple test image:
+   ```bash
+   mkdir src_dir
+   echo "Hello, EROFS world!" > src_dir/hello.txt
+   echo "This is a test file." > src_dir/test.txt
+   ./mkfs/mkfs.erofs test.img src_dir/
+   ```
+
+4. Verify integrity:
+   ```bash
+   ./fsck/fsck.erofs test.img
+   # Expected output: "No errors found" or filesystem statistics (no
error messages)
+   ```
+
+5. Mount and explore (using FUSE =E2=80=94 no kernel module required):
+   ```bash
+   mkdir mnt
+   ./fuse/erofsfuse test.img mnt/
+   ls mnt/                # Should list hello.txt and test.txt
+   cat mnt/hello.txt      # Hello, EROFS world!
+   fusermount -u mnt/     # Unmount when done
+   ```
+
+6. Clean up:
+   ```bash
+   rm -rf src_dir mnt test.img
+   ```
+
+7. Compressed images:
+   ```bash
+   ./mkfs/mkfs.erofs -zlz4hc test-compressed.img src_dir/
+   ```
+   For compressed images, add e.g. `-zlz4hc` or `-zzstd` (or other
algorithms) to `mkfs.erofs`.
+   See the `mkfs.erofs` section below for advanced options (big pclusters,
+   multi-algorithms, reproducible builds, etc.).
+

 mkfs.erofs
 ----------
@@ -283,6 +342,14 @@ feel free to send feedback and/or patches to:
   linux-erofs mailing list   <linux-erofs@lists.ozlabs.org>


+Upstream and Community
+----------------------
+
+- Canonical upstream:
https://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs-utils.git
+- Discussion / patches: linux-erofs@lists.ozlabs.org (subscribe:
https://lists.ozlabs.org/listinfo/linux-erofs)
+- Kernel docs: https://www.kernel.org/doc/html/next/filesystems/erofs.html
+
+
 Comments
 --------

--=20
2.39.5

