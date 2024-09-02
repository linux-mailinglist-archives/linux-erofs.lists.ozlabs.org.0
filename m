Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id B5FF3967EA0
	for <lists+linux-erofs@lfdr.de>; Mon,  2 Sep 2024 06:51:21 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lists.ozlabs.org;
	s=201707; t=1725252679;
	bh=V9ybVcqcmUCTdhQPaBEfWDGyePn6m3S8uZGJzWuskY8=;
	h=To:Subject:Date:List-Id:List-Unsubscribe:List-Archive:List-Post:
	 List-Help:List-Subscribe:From:Reply-To:Cc:From;
	b=DYfd/N4+WmMuZuNcFI6UtTYncIwU6YUCjlRmYn+hA3Vi+rpfFL7UiBi6TACV04Pd9
	 Ui6DG0Epjw9YJYxOoAakmYPL7iiCX4d6VMnrvse1EdmuGcKGKOebq5KqelDeQd5j4D
	 GocqTMCTSpEnKaddD+L0Kn1SY9c5qI/Aa2hvaQG42w3UKVQyLJOoUJOX5d6Ip2AntS
	 wr6XQTY5t6bza4+xfPOHG7beUzIRRrUBdA+29BW+cdP8dpDGfpn0m5s+SrHVzF58//
	 Nr4fkfgXlYtUb41NtBcTdMJ+r23ekd0+2LvgbVfex1OFwe9mr6G5SMWHQMNzYldoft
	 kYbv+0ftlEU+A==
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4WxxD72Cybz2yLV
	for <lists+linux-erofs@lfdr.de>; Mon,  2 Sep 2024 14:51:19 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.135.17.20
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1725252676;
	cv=none; b=QzPXxvQVhdPQyb+fsmIBS9/XW2/Pa99Wv/nqNr0Uem1glTTxs1wFSIApsFWzozQR9OyxavOBtlbCbKw3K4nYHGgLzLtlsDJS+2vDIcxSMSYqevyVC4TJxSnoojNBGA+8cc2FcJOPZLGJ881pMbURr0OGL927aiwRFaGSNCrDLb8ofWCnZomR4JVa6ggfiA/op+WCNfsJjtWR2BI50oyspl92daFRoc7LXIBGvg5IeirMjiDxOfdoD3qdLA7k/DplfVRyyhaZiT0TXnjIkAGjN7EKmu2wnza0Zz8OXaEGUAfjnwP6mNbZnu3tq5lCzQ19QKwtJAuAlWc6FRfetsYnfg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1725252676; c=relaxed/relaxed;
	bh=V9ybVcqcmUCTdhQPaBEfWDGyePn6m3S8uZGJzWuskY8=;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 X-Last-TLS-Session-Version; b=i+63lAvCUqkIrbY1y26ItL9I8W70goREcA3gcxiyqhp/pPuNtm6qpLHtLamB70LyHbnEMyAHuGrKmuxUzzQO2Ohwx4qLGcSmrPGtM5JbuWojKiSzdDjDNgFY0JI9joFaIoKsZI4UGsR1dNHYwJrsSw3v9KzXv2sDolcQsTpzWH8DdlrIi7ob4MuSZ1ybWZDmtBskUr1nx51DOZzCCaQ8s40M+QgCaVjYxNppYYC5pAEHcsdlX0HXmziKiW0VTLKcx2hxNFQHMyyMWkwBogBcpDAb72vDdvQKDu0I960nIFllj4BF+FjVHRSxrr5Ozkk5WOCWRbPwE4vDIuYuVvTK2Q==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=tlmp.cc; dkim=pass (2048-bit key; secure) header.d=tlmp.cc header.i=@tlmp.cc header.a=rsa-sha256 header.s=dkim header.b=KD3xzS7e; dkim-atps=neutral; spf=pass (client-ip=148.135.17.20; helo=mail.tlmp.cc; envelope-from=toolmanp@tlmp.cc; receiver=lists.ozlabs.org) smtp.mailfrom=tlmp.cc
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=tlmp.cc
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; secure) header.d=tlmp.cc header.i=@tlmp.cc header.a=rsa-sha256 header.s=dkim header.b=KD3xzS7e;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=tlmp.cc (client-ip=148.135.17.20; helo=mail.tlmp.cc; envelope-from=toolmanp@tlmp.cc; receiver=lists.ozlabs.org)
Received: from mail.tlmp.cc (unknown [148.135.17.20])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4WxxD424f0z2xZt
	for <linux-erofs@lists.ozlabs.org>; Mon,  2 Sep 2024 14:51:16 +1000 (AEST)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 7B0636983D;
	Mon,  2 Sep 2024 00:51:04 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tlmp.cc; s=dkim;
	t=1725252671; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding; bh=V9ybVcqcmUCTdhQPaBEfWDGyePn6m3S8uZGJzWuskY8=;
	b=KD3xzS7etzilIXTh4YE3Xf2aPghS7zXfg2z6weJ+WKVGafy+78mnMqnKnMyFPfvtyTt8L2
	luliAqsOGjGN3rQbPZ9qNaeqttwu3XyxaXInCuUQtBU8OJvWjj0c1+UEakb/ikbqCxSRmX
	u64uNHIdp8ce2B8zS/3Slkd+ITy/uTAgAcJhM8Ga+h3Z0E8NHq6M6nEMRXoi5jZ4ZOZ5on
	Br6BomievOP0y+V6m83r2Ej9kmtF3kGNHBY2YkbnW6VM2Ve6dHD39Mmcpcn8IAgUIh4XxL
	1qoCHj3skVCZdAZ/NFVxjkywkm+ocruUpuH/8mtNZvWKBLR90lUVYVWEPFMHwA==
To: hsiangkao@linux.alibaba.com
Subject: [PATCH 0/2] erofs: refactor fast_symlink and read_inode
Date: Mon,  2 Sep 2024 12:50:58 +0800
Message-ID: <20240902045100.285477-1-toolmanp@tlmp.cc>
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
Cc: linux-erofs@lists.ozlabs.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

This patchset is response to the original suggestions posted here[1].
Since my later work is somehow related to this issue, i think it's
better to deal with this issue first.

[1]: https://lore.kernel.org/all/20240425222847.GN2118490@ZenIV/

Yiyang Wu (2):
  erofs: refactor read_inode calling convention
  erofs: use kmemdup_nul in erofs_fill_symlink

 fs/erofs/inode.c | 161 ++++++++++++++++++++++++-----------------------
 1 file changed, 83 insertions(+), 78 deletions(-)

-- 
2.46.0

