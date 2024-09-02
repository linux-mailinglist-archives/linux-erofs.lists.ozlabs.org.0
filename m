Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id E0EFF9681DF
	for <lists+linux-erofs@lfdr.de>; Mon,  2 Sep 2024 10:30:36 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lists.ozlabs.org;
	s=201707; t=1725265834;
	bh=qrCNvicodlSdNtI3m0rhOX/zs3Y0RyZj7feiE8HzeJE=;
	h=To:Subject:Date:List-Id:List-Unsubscribe:List-Archive:List-Post:
	 List-Help:List-Subscribe:From:Reply-To:Cc:From;
	b=XeeSLiCiNUlspNbPbWPuB+t8iWRYfShu4lDSctc57RPbzhbJRofumuI5QkyfEAbU1
	 aetxhybQ9fjvEJELnvpF1HylnCMopoINwxLxo9ziyfM1Hvpw8qWZxpGdRkQOXufy2j
	 GULPShOrNnEmM1gmkUbynQk3IzmbFy2RtmA3v5ObOuz/7cPkqGfNZSe8zwx5x5uehb
	 OU3QznCIuuWzNuoL9qqRcR/JjqaMwTfW8HsDE7t/iSwIbjqxIaYivwl5fqvj4B5oWw
	 VJgXQJkhR5yI+0pKw6z8uOKEW0Mpc+2aBe5dg26TxwGxhZko/7U1hJwgvIdKz2RbyY
	 +k5LbaCvUfkzw==
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Wy2563glsz2yNc
	for <lists+linux-erofs@lfdr.de>; Mon,  2 Sep 2024 18:30:34 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.135.17.20
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1725265832;
	cv=none; b=JTz1THueKNwD/VSSq0CbnuSxsxId4phToX6KvQAKWnqX/OuEF4/7OWzIEQyOipf6ub9C7eIp7WaYKc/wuZ40f6URjNzUNwhvONsch4J5XY0nN17bVtZxCs0q1f7npv3SGaMLg72kHkK+JKAhkVdOAtp1Rtp30hm6t5OJ3xRLuLm2r9h3zknT8dOKEHdzgGfSdaX+jDQdfMM/UX6qewlqpKmXCav096MK7BCkNYG25JZFj6eXc82npMIzMoSqLCuvAYcb9M+Y5nbBXJHIkODjKD35pxwwIRNhTXlQwTnVO2RdDlBQRq1RfGlkuPpJy/SZyAQH/TQYalM5uwZvJZT2nA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1725265832; c=relaxed/relaxed;
	bh=qrCNvicodlSdNtI3m0rhOX/zs3Y0RyZj7feiE8HzeJE=;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 X-Last-TLS-Session-Version; b=E/xIta1vNoetRPc1shXlfSql5ZH/gu847lKgKRW5RKpkMHNhu0eTXsS29MfIIwxCjn3H57oB4OKF3eGcKOBOlejohlU/P2nDwCzqJPJ/b25J4R7r+MwQzL0su8Fu3UAA/g/IAfD5AdN13aJJc4qEhMILU6I9VqyrXhY/BuLqcpl8vQlctpEny16aoGRGdB9fcN3OdCIQQrqmunt7t27cYbzhbSZ1aokDvRO+bBbwjmryFGpAPILb6wn78TVVGAEyHTfRhqfRk3XTXCJohpUEEDXBnMyaq9Qa7MT6WqyZknYgeFvdKzGxjV/zRO5rZQXq1VFPcOWMNoc9uazZ4+C2UA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=tlmp.cc; dkim=pass (2048-bit key; secure) header.d=tlmp.cc header.i=@tlmp.cc header.a=rsa-sha256 header.s=dkim header.b=olDWk6XD; dkim-atps=neutral; spf=pass (client-ip=148.135.17.20; helo=mail.tlmp.cc; envelope-from=toolmanp@tlmp.cc; receiver=lists.ozlabs.org) smtp.mailfrom=tlmp.cc
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=tlmp.cc
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; secure) header.d=tlmp.cc header.i=@tlmp.cc header.a=rsa-sha256 header.s=dkim header.b=olDWk6XD;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=tlmp.cc (client-ip=148.135.17.20; helo=mail.tlmp.cc; envelope-from=toolmanp@tlmp.cc; receiver=lists.ozlabs.org)
Received: from mail.tlmp.cc (unknown [148.135.17.20])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Wy2542lBqz2xb9
	for <linux-erofs@lists.ozlabs.org>; Mon,  2 Sep 2024 18:30:32 +1000 (AEST)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 8A3E269799;
	Mon,  2 Sep 2024 04:30:26 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tlmp.cc; s=dkim;
	t=1725265829; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding; bh=qrCNvicodlSdNtI3m0rhOX/zs3Y0RyZj7feiE8HzeJE=;
	b=olDWk6XDyTNXfPWufG3Oj3xdoICOCgnTNEpWGXoGNj9lvYiyMUG4Vy/w3dUrbOr0DJb626
	dknvMR9yVlLpHk0w0lHrTySRjvjgfglsw60sA6Uko8Az2wvmKpKnOdMWGsBOqn+YpziFSX
	vkb1Pq3SaUpasfuzmDxblGOTq9lpVute9aHjlA6TM4eO64wHt6H7oYlkVFWXfYwDrQN8Oi
	kehSPDV+dXIKckWkQi4sMsmIx07RBlVndUP8gC+9GkZHJSP6dlTgcB23yW6M8qXrVNmIVe
	sqqxlJ3jUgiqaOzubNJpl15CGA+GHo1thg04qeqHDp9UHgq00UjQUdw+101ZVg==
To: hsiangkao@linux.alibaba.com
Subject: 
Date: Mon,  2 Sep 2024 16:30:22 +0800
Message-ID: <20240902083024.448367-1-toolmanp@tlmp.cc>
X-Mailer: git-send-email 2.46.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
X-BeenThere: linux-erofs@lists.ozlabs.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Development of Linux EROFS file system <linux-erofs.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linux-erofs>,
 <mailto:linux-erofs-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linux-erofs/>
List-Post: <mailto:linux-erofs@lists.ozlabs.org>
List-Help: <mailto:linux-erofs-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linux-erofs>,
 <mailto:linux-erofs-request@lists.ozlabs.org?subject=subscribe>
From: Yiyang Wu via Linux-erofs <linux-erofs@lists.ozlabs.org>
Reply-To: Yiyang Wu <toolmanp@tlmp.cc>
Cc: linux-erofs@lists.ozlabs.org, linux-kernel@vger.kernel.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Subject: [PATCH V4 0/2] erofs: refactor fast_symlink and read_inode

This patchset is response to the original suggestions posted here[1].
Since my later work is somehow related to this issue, i think it's
better to deal with it first.

Changes in V2:
  1. Lift the erofs_fill_symlink patch to 1/2
  2. Fix code styles problems in read_inode patch.
  3. Fix the formatting problems caused by clang-format.

Changes in V3:
  1. Remove some redundant variables and statements in both patches.

Changes in V4:
  1. Remove out_unlock in erofs_fill_inode and use early returns.
  2. Fix missing initializer for erofs_buf in erofs_read_inode.

[1]: https://lore.kernel.org/all/20240425222847.GN2118490@ZenIV/

Yiyang Wu (2):
  erofs: use kmemdup_nul in erofs_fill_symlink
  erofs: refactor read_inode calling convention

 fs/erofs/inode.c | 133 ++++++++++++++++++++++-------------------------
 1 file changed, 61 insertions(+), 72 deletions(-)

-- 
2.46.0

