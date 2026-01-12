Return-Path: <linux-erofs+bounces-1822-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id A7154D11742
	for <lists+linux-erofs@lfdr.de>; Mon, 12 Jan 2026 10:18:15 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4dqRcj1XrYz302l;
	Mon, 12 Jan 2026 20:18:13 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=209.85.208.65
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1768209493;
	cv=none; b=GPiuXSsUyzG9usE0BBBtGb1rOQWtsY+6YbrRkjW4FcPKfrHtSMYiMfr/aF0R99b79J3wHk0mK7VqoPHS+Is91EnqznRStu/CD/hi0oF8+PVZpkw0LvSWquznyiTnajcJrLDR0zkFe8wjbwNoG10yQ22902B4URAxAJkc7qsRGMk0FsFCzZJSkIpHYGJUc92rMas8cCCIqDaU0sxDy5HveBdP1MMOYldtmj9WsTHnije1yuVtlMQbckgNWs8/5NCvNdKeWUKXwMlqM99e0GAnXCTmygfM54afd5kGNVf0dIDbMKD2PGSrLRjefFOMgxzxTD49G4I8e3vsHRr05REyyA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1768209493; c=relaxed/relaxed;
	bh=zd0BPdweYbYZbQyn2qW1okTKg1KegiW0299KXASGYXY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=WPI22FqvtlQVvlqX3GKqA9No6HtbfavQ5PLNHz2rIhCVlSkOXy/ttZT4OBpDnXCIL1GHLol4mSfUtAgnFrSFV7rmvLyGT/d+2SiTk6uo5T2nzuGbkrmK4wGWJK7bU5JBHF7txSHhjUXRr4DV+AcvwrAsIfWE8VKQ3Db66MMP974WYDTeth+sfXBdYVlF6A6FApMFYsL+f3flCGcjoErELhY7yUWtHVt8XWHHdVu/vr/Wk6zneyJHEhBS8wln4QxcId6dYYzNFSWVM7fztHHSdofmr2fwDdhj/7Hm9UvBfVOi8Jr2mrFJC4ElCpClZoitxcSJPy09ajAmNYtJbgcpvg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=jkUmxIUQ; dkim-atps=neutral; spf=pass (client-ip=209.85.208.65; helo=mail-ed1-f65.google.com; envelope-from=officialnaumansabir@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=jkUmxIUQ;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=209.85.208.65; helo=mail-ed1-f65.google.com; envelope-from=officialnaumansabir@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-ed1-f65.google.com (mail-ed1-f65.google.com [209.85.208.65])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4dqRcg2Gjwz302K
	for <linux-erofs@lists.ozlabs.org>; Mon, 12 Jan 2026 20:18:10 +1100 (AEDT)
Received: by mail-ed1-f65.google.com with SMTP id 4fb4d7f45d1cf-64b92abe63aso12452844a12.0
        for <linux-erofs@lists.ozlabs.org>; Mon, 12 Jan 2026 01:18:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768209428; x=1768814228; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=zd0BPdweYbYZbQyn2qW1okTKg1KegiW0299KXASGYXY=;
        b=jkUmxIUQpMCfHfvuzIl3/k20YZGVgr+cglWmQHyzxtsi0F148egQDOCok/8+hHwbyd
         W66qHOKO+4qQro00bQop6ZBNHqGwwDNXJ4Y9ZBEpQ38idOy6wd+AKxC+I7f0HGa8JZHx
         De+i0Y6jRXNuAGHrjGpveJivYVdwCBVDtCjKneSDlPaa4Oz0qwhrdEkFWgeKuP2xPL08
         LOzEEoYBl7wBHLnZGUser38g/pi+xdqIH8sSo9TkMwh0EisrWoZ+7kFduho79+WNvjN2
         PmBfklh8PrCk5V3DmTL3r92TVFQJwiJGvdPlLJ+N49HvcG/FatUuybdjosn0mhfQXI65
         JL3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768209428; x=1768814228;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zd0BPdweYbYZbQyn2qW1okTKg1KegiW0299KXASGYXY=;
        b=u7xIMoHFdCIMGD/PNl+YlfygnxwdMeTpCdZc4KCjA/vTuP44HkIvyheY+U++KplafZ
         7JrvdMrf1R53OblsVrDRO8IeihxLXsnyb/5f1iGg6ltYlkhbdNRdeWYb3WmcggC+bZtT
         9xG+dfEhpiivsibGFvSo38862fs8/zMx/kgfpbGuaSW6bMYSY9AJpXeBE63AWr8gvA4H
         LVrvkVPZI23AlWaV+KX+XSLz13JIl+eatYnxamlmhXR7zh8SriA2CXgJu+FiwfB8UpcL
         MAxVHR5pH1khOXDQbzt7yq02EbVS+aegyYIJLhANKcJNDmysaKEi98nODH1Nu3Pdd+b5
         1kYA==
X-Forwarded-Encrypted: i=1; AJvYcCW1mN8zUgwOGkBOmeNlBGY4nqzzfrA+EBfOd2/Hu4q4Fmu62/PImpiyGckt4jfv8fV+/w29Y9bbb15JKg==@lists.ozlabs.org
X-Gm-Message-State: AOJu0Yx5EzfFVagajWtWkLL8BexYEzrVrRqzR3GY0GzbRS5E4mv19l5Q
	FLk3dUFb0A6n5EooH73Nar01fAKgnhyUZjqTECRlqx9ve81qc0nGKiuX
X-Gm-Gg: AY/fxX7qXj0M85D7kwZZ5/L//gT9LBp0QJxMGQ35vEXWAyLTgjwMW/sF2aWhYOOfMNi
	ZLEByScdGgAJNL3SQ7W8YpwUCJr5JURlwei9t3cJO3iJpMIvNP88hH5qn82K3mCcgyODxtltfb3
	f1Co0AzHrAZ/fjt6F54cayF9+Va7bTzcJkJodZRqgDAwh/zyYB9sVWL0tM31tKiz2v+rAGmJJtl
	p/loFE9t2BQ7TGRXw4Ydw+5FFF8DEog8f6FmsG7L8ZgRQWi6ydPraUD8BagwdjUUAKMvU1lHKGr
	OaDt5nIwSUXHr50E0qRH2QKiVt9nf7nd7UMtLseb84yL6VFP9tXFddNPW0tkDKg8h3coheaI+h1
	1OBVYvbWB7zOv9bm1gWSbPu+CJb6nZBfLg3YXyoIDP9eC/2YDzB61mYKbagBodB/moi8xfsoAbR
	W7Rx1zGUvTNg7ZPBwoOzrnhikFIpVT2zb4E+kYoh4E7ak=
X-Google-Smtp-Source: AGHT+IEVkFHwWdARDiOC3T5oubH1b0HSoQYmd/NAnJNXQ0ysw0Xt1Fgn+FqRVmFL8guwSSYOYkTxEQ==
X-Received: by 2002:a17:907:7202:b0:b87:efa:8786 with SMTP id a640c23a62f3a-b870efae612mr369083166b.55.1768209427070;
        Mon, 12 Jan 2026 01:17:07 -0800 (PST)
Received: from MacBookPro ([2a02:8071:2186:3703:6de9:eb98:99c8:7af2])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b870b0dba4esm411401466b.17.2026.01.12.01.17.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Jan 2026 01:17:06 -0800 (PST)
From: Nauman Sabir <officialnaumansabir@gmail.com>
To: Jonathan Corbet <corbet@lwn.net>,
	linux-doc@vger.kernel.org
Cc: Nauman Sabir <officialnaumansabir@gmail.com>,
	Tejun Heo <tj@kernel.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	=?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>,
	Chun-Kuang Hu <chunkuang.hu@kernel.org>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Gao Xiang <xiang@kernel.org>,
	Chao Yu <chao@kernel.org>,
	Yue Hu <zbestahu@gmail.com>,
	Jeffle Xu <jefflexu@linux.alibaba.com>,
	Sandeep Dhavale <dhavale@google.com>,
	Hongbo Li <lihongbo22@huawei.com>,
	Chunhai Guo <guochunhai@vivo.com>,
	Nathan Chancellor <nathan@kernel.org>,
	Nicolas Schier <nsc@kernel.org>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Jitao shi <jitao.shi@mediatek.com>,
	linux-kernel@vger.kernel.org,
	cgroups@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	linux-mediatek@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-erofs@lists.ozlabs.org,
	linux-kbuild@vger.kernel.org,
	workflows@vger.kernel.org,
	linux-media@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH v2] Documentation: Fix typos and grammatical errors
Date: Mon, 12 Jan 2026 10:16:56 +0100
Message-ID: <20260112091659.12316-1-officialnaumansabir@gmail.com>
X-Mailer: git-send-email 2.52.0
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
	RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=disabled
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org

Fix various typos and grammatical errors across multiple documentation
files to improve clarity and consistency.

Changes include:
- Fix missing preposition 'in' in process/changes.rst
- Correct 'result by' to 'result from' in admin-guide/README.rst
- Fix 'before hand' to 'beforehand' (3 instances) in cgroup-v1/hugetlb.rst
- Correct 'allows to limit' to 'allows limiting' in cgroup-v1/hugetlb.rst,
  cgroup-v2.rst, and kconfig-language.rst
- Fix 'needs precisely know' to 'needs to precisely know' in
  cgroup-v1/hugetlb.rst
- Correct 'overcommited' to 'overcommitted' in cgroup-v1/hugetlb.rst
- Fix subject-verb agreement: 'never causes' to 'never cause' (2 instances)
  in cgroup-v1/hugetlb.rst
- Fix subject-verb agreement: 'there is enough' to 'there are enough' in
  cgroup-v1/hugetlb.rst
- Remove incorrect plural from uncountable nouns: 'metadatas' to 'metadata'
  in filesystems/erofs.rst, and 'hardwares' to 'hardware' in
  devicetree/bindings/.../mediatek,dp.yaml, userspace-api/.../legacy_dvb_audio.rst,
  and scsi/ChangeLog.sym53c8xx

Note: British spelling 'recognised' retained per maintainer feedback.

These corrections improve the overall quality and readability of the
kernel documentation.

Signed-off-by: Nauman Sabir <officialnaumansabir@gmail.com>
---
 Documentation/admin-guide/README.rst           |  2 +-
 .../admin-guide/cgroup-v1/hugetlb.rst          | 18 +++++++++---------
 Documentation/admin-guide/cgroup-v2.rst        |  2 +-
 .../bindings/display/mediatek/mediatek,dp.yaml |  2 +-
 Documentation/filesystems/erofs.rst            |  2 +-
 Documentation/kbuild/kconfig-language.rst      |  2 +-
 Documentation/process/changes.rst              |  2 +-
 Documentation/scsi/ChangeLog.sym53c8xx         |  2 +-
 .../media/dvb/legacy_dvb_audio.rst             |  2 +-
 9 files changed, 17 insertions(+), 17 deletions(-)

diff --git a/Documentation/admin-guide/README.rst b/Documentation/admin-guide/README.rst
index 05301f03b..77fec1de6 100644
--- a/Documentation/admin-guide/README.rst
+++ b/Documentation/admin-guide/README.rst
@@ -53,7 +53,7 @@ Documentation
    these typically contain kernel-specific installation notes for some
    drivers for example. Please read the
    :ref:`Documentation/process/changes.rst <changes>` file, as it
-   contains information about the problems, which may result by upgrading
+   contains information about the problems which may result from upgrading
    your kernel.
 
 Installing the kernel source
diff --git a/Documentation/admin-guide/cgroup-v1/hugetlb.rst b/Documentation/admin-guide/cgroup-v1/hugetlb.rst
index 493a8e386..b5f3873b7 100644
--- a/Documentation/admin-guide/cgroup-v1/hugetlb.rst
+++ b/Documentation/admin-guide/cgroup-v1/hugetlb.rst
@@ -77,7 +77,7 @@ control group and enforces the limit during page fault. Since HugeTLB
 doesn't support page reclaim, enforcing the limit at page fault time implies
 that, the application will get SIGBUS signal if it tries to fault in HugeTLB
 pages beyond its limit. Therefore the application needs to know exactly how many
-HugeTLB pages it uses before hand, and the sysadmin needs to make sure that
+HugeTLB pages it uses beforehand, and the sysadmin needs to make sure that
 there are enough available on the machine for all the users to avoid processes
 getting SIGBUS.
 
@@ -91,23 +91,23 @@ getting SIGBUS.
   hugetlb.<hugepagesize>.rsvd.usage_in_bytes
   hugetlb.<hugepagesize>.rsvd.failcnt
 
-The HugeTLB controller allows to limit the HugeTLB reservations per control
+The HugeTLB controller allows limiting the HugeTLB reservations per control
 group and enforces the controller limit at reservation time and at the fault of
 HugeTLB memory for which no reservation exists. Since reservation limits are
-enforced at reservation time (on mmap or shget), reservation limits never causes
-the application to get SIGBUS signal if the memory was reserved before hand. For
+enforced at reservation time (on mmap or shget), reservation limits never cause
+the application to get SIGBUS signal if the memory was reserved beforehand. For
 MAP_NORESERVE allocations, the reservation limit behaves the same as the fault
 limit, enforcing memory usage at fault time and causing the application to
 receive a SIGBUS if it's crossing its limit.
 
 Reservation limits are superior to page fault limits described above, since
 reservation limits are enforced at reservation time (on mmap or shget), and
-never causes the application to get SIGBUS signal if the memory was reserved
-before hand. This allows for easier fallback to alternatives such as
+never cause the application to get SIGBUS signal if the memory was reserved
+beforehand. This allows for easier fallback to alternatives such as
 non-HugeTLB memory for example. In the case of page fault accounting, it's very
-hard to avoid processes getting SIGBUS since the sysadmin needs precisely know
-the HugeTLB usage of all the tasks in the system and make sure there is enough
-pages to satisfy all requests. Avoiding tasks getting SIGBUS on overcommited
+hard to avoid processes getting SIGBUS since the sysadmin needs to precisely know
+the HugeTLB usage of all the tasks in the system and make sure there are enough
+pages to satisfy all requests. Avoiding tasks getting SIGBUS on overcommitted
 systems is practically impossible with page fault accounting.
 
 
diff --git a/Documentation/admin-guide/cgroup-v2.rst b/Documentation/admin-guide/cgroup-v2.rst
index 7f5b59d95..098d6831b 100644
--- a/Documentation/admin-guide/cgroup-v2.rst
+++ b/Documentation/admin-guide/cgroup-v2.rst
@@ -2816,7 +2816,7 @@ DMEM Interface Files
 HugeTLB
 -------
 
-The HugeTLB controller allows to limit the HugeTLB usage per control group and
+The HugeTLB controller allows limiting the HugeTLB usage per control group and
 enforces the controller limit during page fault.
 
 HugeTLB Interface Files
diff --git a/Documentation/devicetree/bindings/display/mediatek/mediatek,dp.yaml b/Documentation/devicetree/bindings/display/mediatek/mediatek,dp.yaml
index 274f59080..8f4bd9fb5 100644
--- a/Documentation/devicetree/bindings/display/mediatek/mediatek,dp.yaml
+++ b/Documentation/devicetree/bindings/display/mediatek/mediatek,dp.yaml
@@ -11,7 +11,7 @@ maintainers:
   - Jitao shi <jitao.shi@mediatek.com>
 
 description: |
-  MediaTek DP and eDP are different hardwares and there are some features
+  MediaTek DP and eDP are different hardware and there are some features
   which are not supported for eDP. For example, audio is not supported for
   eDP. Therefore, we need to use two different compatibles to describe them.
   In addition, We just need to enable the power domain of DP, so the clock
diff --git a/Documentation/filesystems/erofs.rst b/Documentation/filesystems/erofs.rst
index 08194f194..e61db115e 100644
--- a/Documentation/filesystems/erofs.rst
+++ b/Documentation/filesystems/erofs.rst
@@ -154,7 +154,7 @@ to be as simple as possible::
   0 +1K
 
 All data areas should be aligned with the block size, but metadata areas
-may not. All metadatas can be now observed in two different spaces (views):
+may not. All metadata can be now observed in two different spaces (views):
 
  1. Inode metadata space
 
diff --git a/Documentation/kbuild/kconfig-language.rst b/Documentation/kbuild/kconfig-language.rst
index abce88f15..7067ec3f0 100644
--- a/Documentation/kbuild/kconfig-language.rst
+++ b/Documentation/kbuild/kconfig-language.rst
@@ -216,7 +216,7 @@ applicable everywhere (see syntax).
 
 - numerical ranges: "range" <symbol> <symbol> ["if" <expr>]
 
-  This allows to limit the range of possible input values for int
+  This allows limiting the range of possible input values for int
   and hex symbols. The user can only input a value which is larger than
   or equal to the first symbol and smaller than or equal to the second
   symbol.
diff --git a/Documentation/process/changes.rst b/Documentation/process/changes.rst
index 62951cdb1..0cf97dbab 100644
--- a/Documentation/process/changes.rst
+++ b/Documentation/process/changes.rst
@@ -218,7 +218,7 @@ DevFS has been obsoleted in favour of udev
 Linux documentation for functions is transitioning to inline
 documentation via specially-formatted comments near their
 definitions in the source.  These comments can be combined with ReST
-files the Documentation/ directory to make enriched documentation, which can
+files in the Documentation/ directory to make enriched documentation, which can
 then be converted to PostScript, HTML, LaTex, ePUB and PDF files.
 In order to convert from ReST format to a format of your choice, you'll need
 Sphinx.
diff --git a/Documentation/scsi/ChangeLog.sym53c8xx b/Documentation/scsi/ChangeLog.sym53c8xx
index 3435227a2..6bca91e03 100644
--- a/Documentation/scsi/ChangeLog.sym53c8xx
+++ b/Documentation/scsi/ChangeLog.sym53c8xx
@@ -3,7 +3,7 @@ Sat May 12 12:00 2001 Gerard Roudier (groudier@club-internet.fr)
 	- Ensure LEDC bit in GPCNTL is cleared when reading the NVRAM.
 	  Fix sent by Stig Telfer <stig@api-networks.com>.
 	- Backport from SYM-2 the work-around that allows to support 
-	  hardwares that fail PCI parity checking.
+	  hardware that fails PCI parity checking.
 	- Check that we received at least 8 bytes of INQUIRY response 
 	  for byte 7, that contains device capabilities, to be valid.
 	- Define scsi_set_pci_device() as nil for kernel < 2.4.4.
diff --git a/Documentation/userspace-api/media/dvb/legacy_dvb_audio.rst b/Documentation/userspace-api/media/dvb/legacy_dvb_audio.rst
index 81b762ef1..99ffda355 100644
--- a/Documentation/userspace-api/media/dvb/legacy_dvb_audio.rst
+++ b/Documentation/userspace-api/media/dvb/legacy_dvb_audio.rst
@@ -444,7 +444,7 @@ Description
 ~~~~~~~~~~~
 
 A call to `AUDIO_GET_CAPABILITIES`_ returns an unsigned integer with the
-following bits set according to the hardwares capabilities.
+following bits set according to the hardware's capabilities.
 
 
 -----
-- 
2.52.0


