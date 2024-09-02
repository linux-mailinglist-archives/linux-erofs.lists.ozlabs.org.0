Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 2219D9681E2
	for <lists+linux-erofs@lfdr.de>; Mon,  2 Sep 2024 10:31:04 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lists.ozlabs.org;
	s=201707; t=1725265862;
	bh=qrCNvicodlSdNtI3m0rhOX/zs3Y0RyZj7feiE8HzeJE=;
	h=To:Subject:Date:List-Id:List-Unsubscribe:List-Archive:List-Post:
	 List-Help:List-Subscribe:From:Reply-To:Cc:From;
	b=Zk9LogeY5O6PIqS+zLlhlfabVVw802iAyCyTRcAyOhxfBw75iZlqS+E0JcsbWsvsj
	 2LBBfghDS2DR5e2HZcfwW1UFGNa+3WOeRrfxSi419TQwZ/9cmdaSGgbG/maYYY6vo7
	 Y4gtoEcr5s5ZnHI6+Ng+KEf4aMn2GCS/tMrZVOfSwh7lLCKwfdVFaIS0n1j5hNrDHJ
	 hCxQGh1bZvjgW7fN38oe0BYFHTuUp4gH8ElaSUw1XdwOS0Ckk+/bf7Bp9PhkEJcLH+
	 lYEOtmBVVNV6UYnAPN+f+crHrTT4Bo80eG8mUxCbpaJ1D0PBU9RCE7RmJDZcdopqJW
	 HNF40tgyexnYw==
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Wy25f106Xz2yNc
	for <lists+linux-erofs@lfdr.de>; Mon,  2 Sep 2024 18:31:02 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.135.17.20
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1725265860;
	cv=none; b=ZA91BEDZnoCqya+bQCCzwU3dBkorvj03b+OyfJ7+oliNrS2hb/fI8T7G02EgUIUAJWJk1ZRNnvSK/QR45OwMsYN8rb/YuBEDcMLVldeFjl4ty0x9NLbHPJ2ztnmuGZ1EMSLS+1oNUNxHP15vFjl7r5nqmcUb0zUSDacmos4EvLDGb9WWDtiYEz1dp2sGoMlwUWO9iCINj420N3EyTKhTKA4oNUSiK4dX56ZvITUz/w3qwTjurJnhNCVXWMnUCoSfyrSSy7WqVHxjJAIjlSjE3FVzL1/Qqhm7ddhXjK07P04MGzF8WYCWbOxCEbH0JRbs/sLftZ4kB31eQuYb5O5ReA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1725265860; c=relaxed/relaxed;
	bh=qrCNvicodlSdNtI3m0rhOX/zs3Y0RyZj7feiE8HzeJE=;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 X-Last-TLS-Session-Version; b=NeOD5DqXLS60tgAWbxhQK7ePSYjDwLMAdxPxl5fMVvoKdrrXCP8Ote9fXlcx+ZVXxLDFd0Oq+Z4wpPijr2hwTHWUExd0aCFofjbL0Hr0syfIWuon0MyfSevaZX8dBSUsAYLvHci9ylpXyF/l+8kOBqPmM/rAyHXbVWBbJHyt6KUIgJWY6ywuZhFxLbQXHr1TBiZcaaAUMtXbeKMRcOqCHn2oA6emCexHTIXD2DO9uCBxS+rhYXQBoBFlDJm3fMt9JHwZPw4z5KfmK/wLIIl9bdyFU+6FkOu4zi+jK1Qxy2rB1rcsNj2GDmKEbEoGUafsCE924ilsAAi9ZGAqBo2o7w==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=tlmp.cc; dkim=pass (2048-bit key; secure) header.d=tlmp.cc header.i=@tlmp.cc header.a=rsa-sha256 header.s=dkim header.b=Eu6kKwjW; dkim-atps=neutral; spf=pass (client-ip=148.135.17.20; helo=mail.tlmp.cc; envelope-from=toolmanp@tlmp.cc; receiver=lists.ozlabs.org) smtp.mailfrom=tlmp.cc
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=tlmp.cc
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; secure) header.d=tlmp.cc header.i=@tlmp.cc header.a=rsa-sha256 header.s=dkim header.b=Eu6kKwjW;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=tlmp.cc (client-ip=148.135.17.20; helo=mail.tlmp.cc; envelope-from=toolmanp@tlmp.cc; receiver=lists.ozlabs.org)
Received: from mail.tlmp.cc (unknown [148.135.17.20])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Wy25c0wxzz2xb9
	for <linux-erofs@lists.ozlabs.org>; Mon,  2 Sep 2024 18:31:00 +1000 (AEST)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 79E9B697C9;
	Mon,  2 Sep 2024 04:30:57 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tlmp.cc; s=dkim;
	t=1725265858; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding; bh=qrCNvicodlSdNtI3m0rhOX/zs3Y0RyZj7feiE8HzeJE=;
	b=Eu6kKwjWqrn6qrInDLoHeQ6b0YMOM16lo47VTtUbvsAVV4IckYhjhISlNcQZtW4sIwJ5K5
	L49l6MkdzVlkuDi2nOz0jv0yV1QMh1CYMbdTGUjyeZJIDWf6P5DSo51v9VVFpqARXqZ+P3
	+HFzRymOzaGhsqgm8K4zAqLXhHIfhsa9rt7Dejv+IL3ETib6kesPuwWBxJ7OMtMb/OK8VQ
	lxDYyqNztloYYltAQmJDv023ddNTiWWgdGKhlMzLNqzfG+2jtIeV+a/RW4qYiw+Yijxjun
	ajZVMVn+OH8faFSL1zKMFuVabqqq+QV/MlxxEt5yg90ZhJQQoz96GV4Aa9pALQ==
To: hsiangkao@linux.alibaba.com
Subject: 
Date: Mon,  2 Sep 2024 16:30:53 +0800
Message-ID: <20240902083055.448965-1-toolmanp@tlmp.cc>
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

