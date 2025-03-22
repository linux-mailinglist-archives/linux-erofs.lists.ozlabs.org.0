Return-Path: <linux-erofs+bounces-108-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id D7D87A6CC4A
	for <lists+linux-erofs@lfdr.de>; Sat, 22 Mar 2025 21:35:29 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4ZKrfd4BnQz2ySl;
	Sun, 23 Mar 2025 07:35:21 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=147.75.193.91
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1742675721;
	cv=none; b=KPYW4jUzz7ziWjbkaAq7YU8rgHfnWDSNuBfZNlosdRpmisRU1wz1Yk30xwvM6YeRFPjuh5eV+/kcUoSyK2CBav3sJ+unRWU74J+hUZbEvypyN5J0G587zeUoY8VCxLrQsJ4vLj1W2UYDAy+HeY17OS0sK2QvOkVs6bmscUbzO6BXCZRjWhK7I1RymND2VK3u3HKuVvKJk0JaS+nXc/4fMtHgHG/biBusxMJV+v93khqtBxvj275CAS80CSxN8+vTaM2XY3TMXhJ1qHgK9hTnymLmwSMH1Qtn31gJEXzGV/J05WMiIKDqcpgcIpTVtYWZM9EChQg5tcox7DWDpVqxAg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1742675721; c=relaxed/relaxed;
	bh=duO5zNX4BPItN4CnyOO1ON6hNo9BnJY1G9khkgN99XE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=iPoB6Wxs4rxeph1S1SZWjztT+o0mlo2gjnEVtRadR6h2TaHdAEXCep3bpxcXnKTx+XvlwPsOhK3T2dIUH8vgvsAO8MLRd93NqNviCCEUw5CMmQr7OxKwvXsCM7mVDapsVS+htpMxUVJEb/OxZWYSPHuJmzDDzgycOuIgBQwIqBAnfeVrf0BgUHQ8FNiNgDxvRTnAZ4ayNRNnFvJoUwQGPpqwaasw8Yrs7h9mLKmF5q0IwFeA/+oCpCeJ1O5fGkEL816VEBs1WO4ZdSM67VRqh9n3nFA1oS2LUJ/hrB+nvRTxs7zcV+4zNHR8sSdRry9M66AdRbSJM1Bvd833yqSwaw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=pnww6gE5; dkim-atps=neutral; spf=pass (client-ip=147.75.193.91; helo=nyc.source.kernel.org; envelope-from=devnull+julian.stecklina.cyberus-technology.de@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=pnww6gE5;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=147.75.193.91; helo=nyc.source.kernel.org; envelope-from=devnull+julian.stecklina.cyberus-technology.de@kernel.org; receiver=lists.ozlabs.org)
Received: from nyc.source.kernel.org (nyc.source.kernel.org [147.75.193.91])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4ZKrfb3TRPz2ySm
	for <linux-erofs@lists.ozlabs.org>; Sun, 23 Mar 2025 07:35:19 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by nyc.source.kernel.org (Postfix) with ESMTP id AAB46A4A3A0;
	Sat, 22 Mar 2025 20:29:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 0E5A1C4CEEC;
	Sat, 22 Mar 2025 20:35:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742675715;
	bh=Yaohu7isWY3gNZXnBO5AmDueX4y+9dG81g5HOyB+u24=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=pnww6gE5HsT8SEInP30wiYL7hXXdFdj066RG4AJGdqd/KJ7ySk4RQlTiueXfBwhCK
	 0y3zwSqNLFfbX1qza6Wg78nxcmxdyLL3DZ1IJWgyJpwJ8YEox47J3mPYQfCREnsR87
	 vU9KdPm4ZGx3MUk0ovQ9mTGKbzvQVyNModWhPBlDm3c71qBJz7tUdVBO4EzoUj0wuT
	 6wg/nTO5Ju/uEvfAOC/CYKoaXt2ZwX5U30pVYyJ3Us3A4DMKmCaeIbTM5QIAc1uJ11
	 uXEIPL0f+jJnbdjFYsIPXgYBjYf3J4J5iyvvBL2kPCo4lcNYvPd25Ue/veRnZps5FN
	 6Lzpt2ZLaF/NA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8BF6C3600B;
	Sat, 22 Mar 2025 20:35:14 +0000 (UTC)
From: Julian Stecklina via B4 Relay <devnull+julian.stecklina.cyberus-technology.de@kernel.org>
Date: Sat, 22 Mar 2025 21:34:14 +0100
Subject: [PATCH v2 2/9] initrd: fix double fput for truncated ramdisks
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
Message-Id: <20250322-initrd-erofs-v2-2-d66ee4a2c756@cyberus-technology.de>
References: <20250322-initrd-erofs-v2-0-d66ee4a2c756@cyberus-technology.de>
In-Reply-To: <20250322-initrd-erofs-v2-0-d66ee4a2c756@cyberus-technology.de>
To: Christoph Hellwig <hch@lst.de>, Al Viro <viro@zeniv.linux.org.uk>, 
 Christian Brauner <brauner@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, Gao Xiang <xiang@kernel.org>, 
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-erofs@lists.ozlabs.org, 
 Julian Stecklina <julian.stecklina@cyberus-technology.de>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1742675713; l=1599;
 i=julian.stecklina@cyberus-technology.de; s=20250320;
 h=from:subject:message-id;
 bh=k4g6SAXWuxXSYv2iKkbm/npvjC9+dlFx9G1/+9RZN20=;
 b=rNJ683tIeaNnaJuuNqFjmoLWib1cKLA5DiGdVBrmkGkeiuHZxssO5pP0xtDM/im05voR1Nb/7
 4LsMkMemF0TAw9Mnp7ACjJIxCYIyVq4DeGqjSHbewp8eywATzHjpEsz
X-Developer-Key: i=julian.stecklina@cyberus-technology.de; a=ed25519;
 pk=m051/8gQfs5AmkACfykwRcD6CUr2T7DQ9OA5eBgyy7c=
X-Endpoint-Received: by B4 Relay for
 julian.stecklina@cyberus-technology.de/20250320 with auth_id=363
X-Original-From: Julian Stecklina <julian.stecklina@cyberus-technology.de>
Reply-To: julian.stecklina@cyberus-technology.de
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
	SPF_PASS autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org

From: Julian Stecklina <julian.stecklina@cyberus-technology.de>

When you actually take the exit via devblocks == 0, the code will do
fput(in_file) twice. This was introduced when the APIs where switched
to the file-based APIs.

Remove more of the multi-floppy support from the olden days.

Fixes: bef173299613 ("initrd: switch initrd loading to struct file based APIs")

Signed-off-by: Julian Stecklina <julian.stecklina@cyberus-technology.de>
---
 init/do_mounts_rd.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/init/do_mounts_rd.c b/init/do_mounts_rd.c
index 473f4f9417e157118b9a6e582607435484d53d63..d026df401afa0b7458ab1f266b21830aab974b92 100644
--- a/init/do_mounts_rd.c
+++ b/init/do_mounts_rd.c
@@ -234,20 +234,20 @@ int __init rd_load_image(char *from)
 		goto done;
 	}
 
+	if (devblocks < nblocks) {
+		printk(KERN_ERR "RAMDISK: looks truncated: (%luKiB vs %dKiB) - continuing anyway\n",
+		       devblocks, nblocks);
+		nblocks = devblocks;
+	}
+
 	buf = kmalloc(BLOCK_SIZE, GFP_KERNEL);
 	if (!buf) {
 		printk(KERN_ERR "RAMDISK: could not allocate buffer\n");
 		goto done;
 	}
 
-	printk(KERN_NOTICE "RAMDISK: Loading %dKiB [%ld disk%s] into ram disk... ",
-		nblocks, ((nblocks-1)/devblocks)+1, nblocks>devblocks ? "s" : "");
+	printk(KERN_NOTICE "RAMDISK: Loading %dKiB into ram disk... ", nblocks);
 	for (i = 0; i < nblocks; i++) {
-		if (i && (i % devblocks == 0)) {
-			pr_cont("done disk #1.\n");
-			fput(in_file);
-			break;
-		}
 		kernel_read(in_file, buf, BLOCK_SIZE, &in_pos);
 		kernel_write(out_file, buf, BLOCK_SIZE, &out_pos);
 	}

-- 
2.47.0



