Return-Path: <linux-erofs+bounces-1336-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 56632C2C82B
	for <lists+linux-erofs@lfdr.de>; Mon, 03 Nov 2025 15:58:10 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4d0ZTD2c54z30Vl;
	Tue,  4 Nov 2025 01:58:08 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1762181888;
	cv=none; b=Ge4MTuCWzh/H8Lgjl5CUXLNJjXX5jZXo7LSUDCb/1M9MnBuPdoO4lgzi1naXNC+THYynqmIpPfKuKwSC/W/jt+hkxUQm0M8aYKBwxzrucozWYhz3F7jPETEZ4zVQX2EVTz23d1Q/Rx2OOyVWpWHSJWr+eER6HnFpdH2qR1uEHuGziam1xEc6o99OZyACl2B9aMoEoIbL1Tz/9lViAU64HLq/UlE4jToO7dTtuju3dvQR9zzhMSueZxzfRtiu261b7AjDrlztOW9vz2v5Szo36sk/SthU5GUyywRBB9uccPOEQarY6p35BJ1wo5yt3P9FFpf9d5Hk7f6aTONS6XvTbw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1762181888; c=relaxed/relaxed;
	bh=t4UlRa7THErgiRo9mWVQK9OHIdIzg/oT/MoaSmIiMKs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ODc/mSCVskOL+OCgE/vXvBiZTkWhkMsujI9g7fpLSX9YLrV72CiRgFfyw2hIspyLqxQd6o2elwjr2H4egoSIHyQteyoDCugJC1EAaj3CLgwgcFbc7itAZngRUFiDtWENFqAGCowINN0BvjrD3KgkH4KOd77Zs55Cl5bCsJ7W4IPlh/FhKNXgncDQC0TxUVLuLocH6f5IE0jjuoJHi4rbWRPg2oGN41o6MNOpiQHq7zfgz4yXbVgotAuSfRx46l2VUtvcTEpxlNAZgd9RuOky4/ydaHy6g1djR7LAsgg1Sxw23OhCRcIwPIvMTUB8zXcAnNCcQgTDYNZyFjWmU6eRRA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=k3jenSgj; dkim-atps=neutral; spf=pass (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=brauner@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=k3jenSgj;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=brauner@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4d0ZTC6fM0z2xnx
	for <linux-erofs@lists.ozlabs.org>; Tue,  4 Nov 2025 01:58:07 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 14B5B601B0;
	Mon,  3 Nov 2025 14:58:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2085C19421;
	Mon,  3 Nov 2025 14:58:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762181885;
	bh=pg2v4Qq4p691A716jLKgU9cR9rJWdfU2QnrT9iAtdLo=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=k3jenSgjz87qIYdLxKG5JJW4vxX0/TPxC6CFwTvlx7Tl7n9xE4mlIADEP/AxPoF0k
	 3tHWsJQRfZReyP4rQ+YQZMb3IGYp9s5/GvKHpgXYopc4D7vWRzqJErSHWqp0ROj2Xq
	 ++uF8hSneX2nYhaqRzlD1Ez+xBkz53yTGWIFTOdebt+I7k7+6dn5upLZYqDAldx3pP
	 42Rcni/Xnt5jNXU6QaOy43bHgEsAZAKt2MVBNKePKZi45IFqA9Dwd+KyCcYbW3uXw1
	 hcERYhyvMRY4w7zbRD1Mtuv+R1mzlr01Py/eUnVUwoTd2mK6Pwh9MKVd1ATi12wQyZ
	 VgLHGxzPN5PMw==
From: Christian Brauner <brauner@kernel.org>
Date: Mon, 03 Nov 2025 15:57:31 +0100
Subject: [PATCH 05/12] coredump: move revert_cred() before
 coredump_cleanup()
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
Message-Id: <20251103-work-creds-guards-prepare_creds-v1-5-b447b82f2c9b@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=611; i=brauner@kernel.org;
 h=from:subject:message-id; bh=pg2v4Qq4p691A716jLKgU9cR9rJWdfU2QnrT9iAtdLo=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWRyHHqZ6D57643ky/+/Hb66KPGd3u+ty2sqxY7dP8x1W
 VGzSaXyeUcpC4MYF4OsmCKLQ7tJuNxynorNRpkaMHNYmUCGMHBxCsBE3AIZGd7od/1OWLjnxvcJ
 QtuE5zwRbfra+q7KjcFz9rPzNt/mP8xm+O+68mRGc8RuhsSMUs9/pps+397laOW5KMdl6vUvk+b
 9SGYEAA==
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
X-Spam-Status: No, score=-0.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
	autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org

There's no need to pin the credentials across the coredump_cleanup()
call. Nothing in there depends on elevated credentials.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 fs/coredump.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/coredump.c b/fs/coredump.c
index 5c1c381ee380..4fce2a2f279c 100644
--- a/fs/coredump.c
+++ b/fs/coredump.c
@@ -1197,8 +1197,8 @@ void vfs_coredump(const kernel_siginfo_t *siginfo)
 	}
 
 close_fail:
-	coredump_cleanup(&cn, &cprm);
 	revert_creds(old_cred);
+	coredump_cleanup(&cn, &cprm);
 	return;
 }
 

-- 
2.47.3


