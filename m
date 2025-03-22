Return-Path: <linux-erofs+bounces-105-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id E7E4BA6CC48
	for <lists+linux-erofs@lfdr.de>; Sat, 22 Mar 2025 21:35:24 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4ZKrfd0GHLz2ydQ;
	Sun, 23 Mar 2025 07:35:21 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2604:1380:45d1:ec00::3"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1742675720;
	cv=none; b=j//ytjiAbyy3SueMvx+TYstTzYp7d55B12XQCFYJTho9jJMUD3XSh6U2rJwYDAep8RPsS5Vm86FKk2ln99or4zMZNAreGU87SGVFdhar3PzdlIUzQcO8KAnQURVn2IddstYlIPa6q7xqgnLmcNG7GiSKHQxLwhYXY92BC+dJ2+WfXDnedO7sdFaaxdrZKhZZ/93eErH7a5jQk3xaM/MK/9NYj5m7vuhqud3/b5y4wR0JjKPCQsy4xTDAqWK4+YM2T456/+bal+5aON4SRc0EKhjvKODKn8Nm0YZqiGUw0zIRLe7gyJF7j69jSSe+bTey0R68QmEEJLAWgyWyeA2LIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1742675720; c=relaxed/relaxed;
	bh=4RZebFbCDTNP0V+PCXS2lyneh2/fWP2lrWvX+v7/KBQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=BjL1dOOAXnqGJCpRHkX0BY6tF5L2MRfmpbpnb+svKvn7tXlzOJNEdb1y0rB7u+Da5URViQR20yaObYfNOlRf7aQf01ukga/HNT1rDwal4WgH8PjKXWZ6orsKcFRKYJCe+jwNa28ALG32HMTL4bdEaGzXc4i2tvTnAmLB2wrmGZV6WbQX4rMRh69Q6pJAQl+t2ejCENDZsAmzMdqwT5YeNr8z00pZEKXNDB4e3Yzf2s3sfPC0VeCxxQXscf/KGdaDWmdOMuCzXGeTEW1IwQK+ozJz0Vi5B69fUdPgTnaqSX0bnl9Bp2RHcvzLkDbAKRd2GTYP4LBmrHQ9eVVHUgBYJg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=Ym5YgecI; dkim-atps=neutral; spf=pass (client-ip=2604:1380:45d1:ec00::3; helo=nyc.source.kernel.org; envelope-from=devnull+julian.stecklina.cyberus-technology.de@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=Ym5YgecI;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2604:1380:45d1:ec00::3; helo=nyc.source.kernel.org; envelope-from=devnull+julian.stecklina.cyberus-technology.de@kernel.org; receiver=lists.ozlabs.org)
Received: from nyc.source.kernel.org (nyc.source.kernel.org [IPv6:2604:1380:45d1:ec00::3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4ZKrfb3P0Qz2ySl
	for <linux-erofs@lists.ozlabs.org>; Sun, 23 Mar 2025 07:35:19 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by nyc.source.kernel.org (Postfix) with ESMTP id 91E02A4A261;
	Sat, 22 Mar 2025 20:29:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id ED851C4CEE9;
	Sat, 22 Mar 2025 20:35:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742675715;
	bh=gINZ0Aw8Hylr726Wuv3Tb5zHE90wq70NebX4Kb1KIYg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=Ym5YgecIPYw5eJfx+kMkQLnilWlWcqki58e2BiXmYlEiKRuh5FYyoqddx6+kcQTac
	 OWxuTSsmGQqcR09FuuHnwDww4UJbOFl+K/GJbOTi6BQar/Itk5AaPsSVgeExEYGJML
	 yCC4BjGXgLijc1Fi91VfMQhbF6ndgZiGcBouG2r5DwpLcH+b1vkYs4/5dwiMc/5izA
	 pWUGB3uWI8yHodlIHxBlAWLfSnO3Nb0D6OtNwKbk+ZAJ1Tg++L99PGSqT01MRelcS9
	 hcTU9zo5+3saHvlsCIxRdmvn2XwCgXam6IXqCaIfi6Ux6oEAHnd+1T4Ct4t08cA3q0
	 y7lHKG7UIrCrg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4EC7C36008;
	Sat, 22 Mar 2025 20:35:14 +0000 (UTC)
From: Julian Stecklina via B4 Relay <devnull+julian.stecklina.cyberus-technology.de@kernel.org>
Date: Sat, 22 Mar 2025 21:34:13 +0100
Subject: [PATCH v2 1/9] initrd: remove ASCII spinner
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
Message-Id: <20250322-initrd-erofs-v2-1-d66ee4a2c756@cyberus-technology.de>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1742675713; l=1419;
 i=julian.stecklina@cyberus-technology.de; s=20250320;
 h=from:subject:message-id;
 bh=xaOtsZSXLvGxcDVIZd0k1LuXf7yoO5wFbuBG8A93PMw=;
 b=Q/f0Rz5QFOyX0GFtzyWhjf7NZaw5DwLqmAK+UT+Lih/KQRXWu2ZWjHPR87PxJ073JhZ6qoeo1
 dSKgyuoEHDHC8bSj5x2zOKyRbhADY7Q0NrHhkpa8NkAZjxmafF66erV
X-Developer-Key: i=julian.stecklina@cyberus-technology.de; a=ed25519;
 pk=m051/8gQfs5AmkACfykwRcD6CUr2T7DQ9OA5eBgyy7c=
X-Endpoint-Received: by B4 Relay for
 julian.stecklina@cyberus-technology.de/20250320 with auth_id=363
X-Original-From: Julian Stecklina <julian.stecklina@cyberus-technology.de>
Reply-To: julian.stecklina@cyberus-technology.de
X-Spam-Status: No, score=-1.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org

From: Julian Stecklina <julian.stecklina@cyberus-technology.de>

Writing the ASCII spinner probably costs more cycles than copying the
block of data on some output devices if you output to serial and in
all other cases it rotates at lightspeed in 2025.

Signed-off-by: Julian Stecklina <julian.stecklina@cyberus-technology.de>
---
 init/do_mounts_rd.c | 11 -----------
 1 file changed, 11 deletions(-)

diff --git a/init/do_mounts_rd.c b/init/do_mounts_rd.c
index ac021ae6e6fa78c7b7828a78ab2fa3af3611bef3..473f4f9417e157118b9a6e582607435484d53d63 100644
--- a/init/do_mounts_rd.c
+++ b/init/do_mounts_rd.c
@@ -189,11 +189,7 @@ int __init rd_load_image(char *from)
 	unsigned long rd_blocks, devblocks;
 	int nblocks, i;
 	char *buf = NULL;
-	unsigned short rotate = 0;
 	decompress_fn decompressor = NULL;
-#if !defined(CONFIG_S390)
-	char rotator[4] = { '|' , '/' , '-' , '\\' };
-#endif
 
 	out_file = filp_open("/dev/ram", O_RDWR, 0);
 	if (IS_ERR(out_file))
@@ -249,18 +245,11 @@ int __init rd_load_image(char *from)
 	for (i = 0; i < nblocks; i++) {
 		if (i && (i % devblocks == 0)) {
 			pr_cont("done disk #1.\n");
-			rotate = 0;
 			fput(in_file);
 			break;
 		}
 		kernel_read(in_file, buf, BLOCK_SIZE, &in_pos);
 		kernel_write(out_file, buf, BLOCK_SIZE, &out_pos);
-#if !defined(CONFIG_S390)
-		if (!(i % 16)) {
-			pr_cont("%c\b", rotator[rotate & 0x3]);
-			rotate++;
-		}
-#endif
 	}
 	pr_cont("done.\n");
 

-- 
2.47.0



