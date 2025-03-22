Return-Path: <linux-erofs+bounces-107-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E8A5A6CC49
	for <lists+linux-erofs@lfdr.de>; Sat, 22 Mar 2025 21:35:27 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4ZKrfd3J13z2ySh;
	Sun, 23 Mar 2025 07:35:21 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=139.178.84.217
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1742675721;
	cv=none; b=CXPsFRzAovt7pIrdqtTi4lVy60uW1/2leKlH/nNzp+GZX7uey8KQHI6Pi6KyehwLw0GQNwRFfvEU1+CHg1dhrbt4o4khM9gX1X8Cau0f/MPOpzBN/qZlEpWZZrbabDkNYvWVj3beM9MU7WcJj2dcHR7R4YcZqCyNdI9/Ztek7T8q41E4i98JhLye5q+NT70Qdb3yo+2Lk1uFw6wyNYqn5VfqoNqMvO2k1Szg1cOvqXulRUSxIe3G6rBqT27o1DOkEHX+KLQ6ot4Q1YA4qXhJbaUbHYd4qH8bMnQUaOYt1jg+k87wRPXY/orU4QnEoRFPUrJO/3aahLh2SzSUrRI57g==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1742675721; c=relaxed/relaxed;
	bh=nZAGmlZwhiqZBoXhOGR4vrGflS3zWC6/zziEHigl+IE=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=MtNuH55fteGeWV2WqTQx2OP26QxvQs6PZGbt0Pmco5P1bGujeUbwq5b2TOgj/TaieQkCjOBaAUjLCQZpZLDxZoPoOQl0ulUMDAMCHddcKfzqOs7KDGwtG0/PGYC9bp+SzUxWJlwMigxbKSI/FLmqA8oN63fzyXTTKJgGRJGitdrfRvxYf9WpssAwodsuF0FwitEOdfWPX/tDe9TlTUuWBuxGzjh/oVWLCQGlZVyUGbhlcsfjfV2pyym+HZx2Cy5MZVoQ8GRDSGQN2uA4vLMCAvhB/p2MxDo3OdpijY9dxjyqczsDQc6T//nY8IGM4+YO4fTDHqrW1Dz8R97V/V1/tg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=qQ++w9SX; dkim-atps=neutral; spf=pass (client-ip=139.178.84.217; helo=dfw.source.kernel.org; envelope-from=devnull+julian.stecklina.cyberus-technology.de@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=qQ++w9SX;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=139.178.84.217; helo=dfw.source.kernel.org; envelope-from=devnull+julian.stecklina.cyberus-technology.de@kernel.org; receiver=lists.ozlabs.org)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4ZKrfb3X0Tz2yTP
	for <linux-erofs@lists.ozlabs.org>; Sun, 23 Mar 2025 07:35:19 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 8B05D5C4C25;
	Sat, 22 Mar 2025 20:32:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id E2746C4CEDD;
	Sat, 22 Mar 2025 20:35:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742675715;
	bh=BqYZpH0UiavMMal11keGKaBoUo5bpmMxlDCKzw1Ly2A=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=qQ++w9SX0vNEnL3vYRfbiKR/Qvu+jnUraHP5nquD/6swnBVQDCpp2hj/woU7KuZoh
	 wuVt3Ke2ZH8Ds91dEQauJzAwPkdoJnpL88ZA0KwkcQSkHyTbMe+U/Of3tSvD8HGGHq
	 cGsh/9sxcNGAqBNcNGX/hdj+xmTKLE0tm4xyZffpSrOCkWUzNf6uWpQMr5L3xy8mmj
	 tvYS4Tg1la07G7WRq8kAkCiRNe/ls9A8LsZ2l4rWgRd+/kyBLbECuSqVYCYCF4JsB0
	 /UK1sIOW4FKckBqjmvABIaYgwWYD+Ys75voiqE1sjdJmMGRMbF1ul9f16/xWGnJDuw
	 2TWXyLYJcjZ6g==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1C0EC35FFC;
	Sat, 22 Mar 2025 20:35:14 +0000 (UTC)
From: Julian Stecklina via B4 Relay <devnull+julian.stecklina.cyberus-technology.de@kernel.org>
Subject: [PATCH v2 0/9] initrd: cleanup and erofs support
Date: Sat, 22 Mar 2025 21:34:12 +0100
Message-Id: <20250322-initrd-erofs-v2-0-d66ee4a2c756@cyberus-technology.de>
X-Mailing-List: linux-erofs@lists.ozlabs.org
List-Id: <linux-erofs.lists.ozlabs.org>
List-Help: <mailto:linux-erofs+help@lists.ozlabs.org>
List-Owner: <mailto:linux-erofs+owner@lists.ozlabs.org>
List-Post: <mailto:linux-erofs@lists.ozlabs.org>
List-Subscribe: <mailto:linux-erofs+subscribe@lists.ozlabs.org>,
  <mailto:linux-erofs+subscribe-digest@lists.ozlabs.org>,
  <mailto:linux-erofs+subscribe-nomail@lists.ozlabs.org>
List-Unsubscribe: <mailto:linux-erofs+unsubscribe@lists.ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAMQe32cC/3XMQQ6CMBCF4auQWTsGiiC48h6GBW2nMIlpzRSJh
 PTuVvYu/5e8b4dIwhThVuwgtHLk4HOoUwFmHv1EyDY3qFI1Za1KZM+LWCQJLuK1pV41zrq2M5A
 vLyHHn4N7DLlnjkuQ7dDX6rf+gdYKK6wbrbXq60vbjXezaZJ3xIXM7MMzTNvZEgwppS8JgT30t
 AAAAA==
X-Change-ID: 20250320-initrd-erofs-76e925fdf68c
To: Christoph Hellwig <hch@lst.de>, Al Viro <viro@zeniv.linux.org.uk>, 
 Christian Brauner <brauner@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, Gao Xiang <xiang@kernel.org>, 
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-erofs@lists.ozlabs.org, 
 Julian Stecklina <julian.stecklina@cyberus-technology.de>, 
 Niklas Sturm <niklas.sturm@secunet.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1742675712; l=3257;
 i=julian.stecklina@cyberus-technology.de; s=20250320;
 h=from:subject:message-id;
 bh=BqYZpH0UiavMMal11keGKaBoUo5bpmMxlDCKzw1Ly2A=;
 b=/HaQH4dsGXfsHwAm/6oa8WAEYcLbW08CzgyyRCZ+LZG0q+uisaMe5G6LQ3QXxCEgqyOGnYwUU
 nkvDSuyxtGkAdFImX7HqJ4sntWriaHu7HcpiTN7J586G3+Di7DiIDBv
X-Developer-Key: i=julian.stecklina@cyberus-technology.de; a=ed25519;
 pk=m051/8gQfs5AmkACfykwRcD6CUr2T7DQ9OA5eBgyy7c=
X-Endpoint-Received: by B4 Relay for
 julian.stecklina@cyberus-technology.de/20250320 with auth_id=363
X-Original-From: Julian Stecklina <julian.stecklina@cyberus-technology.de>
Reply-To: julian.stecklina@cyberus-technology.de
X-Spam-Status: No, score=-6.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
	SPF_PASS autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org

On my journey towards adding erofs support for initrd, Al Viro
suggested to move the filesystem detection code into the respective
filesystem modules. This patch series implements this, while also
adding erofs support.

To achieve this, I added a macro initrd_fs_detect() that allows
filesystem modules to add a filesystem detection hooks. I then moved
all existing filesystem detection code to this new API. While I was
there I also tried to clean up some of the code.

I've tested these changes with the following kinds of initrd
images:

- ext2
- Minix v1
- cramfs (padded/unpadded)
- romfs
- squashfs
- erofs

initrds are still relevant, because they have some advantages over
initramfs. They don't require unpacking all files before starting the
init process and allows them to stay compressed in memory. They also
allow using advanced file system features, such as extended
attributes. In the NixOS community, we are heavy users of erofs, due
to its sweet spot of compression, speed and features.

That being said, I'm totally in favor of cutting down the supported
filesystems for initrd and further simplify the code. I would be
surprised, if anyone is using ext2 or Minix v1 filesystems (64 MiB
filesystem size limit!) or cramfs (16 MiB file size limit!) as an
initrd these days! Squashfs and erofs seem genuinely useful, though.

Signed-off-by: Julian Stecklina <julian.stecklina@cyberus-technology.de>
---
Changes in v2:
- Remove more legacy code
- Introduce initrd_fs_detect
- Move all other initrd filesystems to the new API
- Link to v1: https://lore.kernel.org/r/20250320-initrd-erofs-v1-1-35bbb293468a@cyberus-technology.de

---
Julian Stecklina (9):
      initrd: remove ASCII spinner
      initrd: fix double fput for truncated ramdisks
      initrd: add a generic mechanism to add fs detectors
      fs: minix: register an initrd fs detector
      fs: cramfs: register an initrd fs detector
      fs: romfs: register an initrd fs detector
      fs: squashfs: register an initrd fs detector
      fs: ext2, ext4: register an initrd fs detector
      fs: erofs: register an initrd fs detector

 fs/cramfs/Makefile                |   5 ++
 fs/cramfs/initrd.c                |  41 +++++++++++++
 fs/erofs/Makefile                 |   5 ++
 fs/erofs/initrd.c                 |  19 ++++++
 fs/ext2/Makefile                  |   5 ++
 fs/ext2/initrd.c                  |  27 +++++++++
 fs/ext4/Makefile                  |   4 ++
 fs/minix/Makefile                 |   5 ++
 fs/minix/initrd.c                 |  23 +++++++
 fs/romfs/Makefile                 |   4 ++
 fs/romfs/initrd.c                 |  22 +++++++
 fs/squashfs/Makefile              |   5 ++
 fs/squashfs/initrd.c              |  23 +++++++
 include/asm-generic/vmlinux.lds.h |   6 ++
 include/linux/ext2_fs.h           |   9 ---
 include/linux/initrd.h            |  37 ++++++++++++
 init/do_mounts_rd.c               | 122 ++++++++------------------------------
 17 files changed, 257 insertions(+), 105 deletions(-)
---
base-commit: 88d324e69ea9f3ae1c1905ea75d717c08bdb8e15
change-id: 20250320-initrd-erofs-76e925fdf68c

Best regards,
-- 
Julian Stecklina <julian.stecklina@cyberus-technology.de>



