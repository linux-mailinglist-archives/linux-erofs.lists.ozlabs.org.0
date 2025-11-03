Return-Path: <linux-erofs+bounces-1340-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 24CBFC2C83A
	for <lists+linux-erofs@lfdr.de>; Mon, 03 Nov 2025 15:58:24 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4d0ZTV13pDz3bf2;
	Tue,  4 Nov 2025 01:58:22 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1762181902;
	cv=none; b=PkooymQtltHqrwfpG9lMpW9hgEZRjeT556chMFViSQn/y79SewRv0tRhf0i05+lE+WvmWFlo1xI/53AfIjclGEFgUE1OGNJHq9t8t+jOz2TwLBBIw7amL0prqjScYdq1C7V6UhMBlD4M7ZULKn2ufRnv2eoShH3arGSJTRRFgsa547Qbbrvz0KHH6wJe7gUkj55B9vsecruAGCtTsvTPs0XRtLuivxU5BWbyTmn+vISKYPjOadG4lBexmQlw2iXdYFuLZLoH+MpRKtCixyaqsC9l7m1d2CH3BRY5Vu7jA14mrGULzOZ7PDAxHoR4Ji9Pr/rxPUPtjA6y/6TsI7/L2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1762181902; c=relaxed/relaxed;
	bh=0mPa2sIh4tMLW13TMUdtGm7gD5tTB5IKncItLGBqzcA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=YgauVUUxaLKbF3+eV4DewE8fEUH0OF4Aq6GWoWzLRjtydvfSW1G9gnRRW4Sr9+iClNcDszocrF5ix/e47aGyDLqyVdf0xebvRU6/8yQ+/de4n55Nbc3HLgADNAfRmNMqfFnAmOLHVvnEsnELWsRwQafk4j0S5p0UnjtmUSvufLthPUot2W4TAWVDrVHR99ZZDgjBru/UGFhXTExXfEpQHzryNGR4xEZTuAqC4m2M/0pgWR+9OM/tTUrKtQz/W2VShEfLEbTi1QJ8v/UWWzeW530GeEjJvPclX2HIYlTPs8avKXnQxAYuMfYZDyQMSLczgxTEdEsDadETg3e+HSFMvw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=FfjNIE12; dkim-atps=neutral; spf=pass (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=brauner@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=FfjNIE12;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=brauner@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4d0ZTT4786z2xnx
	for <linux-erofs@lists.ozlabs.org>; Tue,  4 Nov 2025 01:58:21 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 7BA6043317;
	Mon,  3 Nov 2025 14:58:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E440C113D0;
	Mon,  3 Nov 2025 14:58:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762181899;
	bh=c3MjjxCah9rBlJv8gEbIO0Wdkh/B50Fpv0CEVpSv9OE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=FfjNIE12fBDXyCnPG4LOVn61IOGzDAi39xv0r51APjfXkGOj6cWQuTRlUj604/ozo
	 Povw9myNuMm1ljtrRCkTqyVh4bFAPTCs5loqrX+7/37CHb+NUsq0s7uHoOpCs/m3ti
	 UMqw0xVtyhjapiaEcXLbqp2RqzD3u0CtRHDEDIvOkmpRwmmku8bQNDtEWl8XEbjf2T
	 uytPDnZZvyinUEWfIBgWUwOxEbJECZAr+mDAzOqt7nIz9SlJctuUzP8lcmv0ZygBRe
	 kouePD9U+wkCEQO5Ou2rYrGTTAZ8uDp3fShajHO2qMGWXF00JVj0vAHAIwmJPM3Bg+
	 yEwQK9iS9JPCQ==
From: Christian Brauner <brauner@kernel.org>
Date: Mon, 03 Nov 2025 15:57:35 +0100
Subject: [PATCH 09/12] coredump: use prepare credential guard
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251103-work-creds-guards-prepare_creds-v1-9-b447b82f2c9b@kernel.org>
References: <20251103-work-creds-guards-prepare_creds-v1-0-b447b82f2c9b@kernel.org>
In-Reply-To: <20251103-work-creds-guards-prepare_creds-v1-0-b447b82f2c9b@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-aio@kvack.org, linux-unionfs@vger.kernel.org, 
 linux-erofs@lists.ozlabs.org, linux-nfs@vger.kernel.org, 
 linux-cifs@vger.kernel.org, samba-technical@lists.samba.org, 
 cgroups@vger.kernel.org, netdev@vger.kernel.org, 
 linux-crypto@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
 Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.15-dev-96507
X-Developer-Signature: v=1; a=openpgp-sha256; l=873; i=brauner@kernel.org;
 h=from:subject:message-id; bh=c3MjjxCah9rBlJv8gEbIO0Wdkh/B50Fpv0CEVpSv9OE=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWRyHHopwsuxvjlnd5bB3CqvS4ZW7CvfJnLHFto9bkkv1
 M8+UL+xo5SFQYyLQVZMkcWh3SRcbjlPxWajTA2YOaxMIEMYuDgFYCIS6owMN9/rS7u0KCxf8ePA
 njVZXecXJj7JeVewWaYwJ7E4WXtFJcM/O6HUn0onP1l6aYpFnFo2/3lXNdNb1hCRqWYmcfwm2wu
 5AQ==
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
X-Spam-Status: No, score=-0.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
	autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org

Use the prepare credential guard for allocating a new set of
credentials.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 fs/coredump.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/fs/coredump.c b/fs/coredump.c
index 79c681f1d647..5424a6c4e360 100644
--- a/fs/coredump.c
+++ b/fs/coredump.c
@@ -1155,7 +1155,6 @@ static void do_coredump(struct core_name *cn, struct coredump_params *cprm,
 
 void vfs_coredump(const kernel_siginfo_t *siginfo)
 {
-	struct cred *cred __free(put_cred) = NULL;
 	size_t *argv __free(kfree) = NULL;
 	struct core_state core_state;
 	struct core_name cn;
@@ -1183,7 +1182,7 @@ void vfs_coredump(const kernel_siginfo_t *siginfo)
 	if (coredump_skip(&cprm, binfmt))
 		return;
 
-	cred = prepare_creds();
+	CLASS(prepare_creds, cred)();
 	if (!cred)
 		return;
 	/*

-- 
2.47.3


