Return-Path: <linux-erofs+bounces-3368-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cKkFCQlI82kMzAEAu9opvQ
	(envelope-from <linux-erofs+bounces-3368-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Thu, 30 Apr 2026 14:16:09 +0200
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F44C4A2A7E
	for <lists+linux-erofs@lfdr.de>; Thu, 30 Apr 2026 14:16:06 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4g5tS31grgz2xjk;
	Thu, 30 Apr 2026 22:16:03 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=157.180.15.194
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1777551363;
	cv=none; b=jSS4YFvxEd/WMKEEh01dtMYWnbZYF3DV8OzPgA001iwXv5x74dqMQwPCMZqW8Twlv/XNEGGnvXlC7zPL4I2BGYlVOnVEbxc3vUv0NBrxkK2lPISsJq+294ogGrB0BhzLeEBwXjlVF+SNFVWFBeuhhw+NDG4nrBoQRfp1RQAiLeWLgpl8gmTxYFrDu2JcRvV20a6ZDU9SiuQ8xAhvUU+zCTrIXfES+9CIxAAC2EivuzupbnGtE+yruxHVzzuTiN+Z4tMOFC39BLrDbyzGr9j6p0FYsWQ2IT0xewRKUiwmTV4vfC/xdlxXzMwxVuY4h93h+GljSraAyTg9evlZBU+Zpw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1777551363; c=relaxed/relaxed;
	bh=TpbMgWffqqFrHPlS/1tiVD+/g31u6U2o636RxeQBUNQ=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=gv6MB+q5+uA66KlZdRWEMcuJgBtuoWrHAc8t/OvdAmG2tdHdjPnx45ABgf0Y0KsSq4M0lXH+5+O0khtNikB2d02Dmx9AmKV6uG9cjv5UU3zsuzCEwuIrNb1IlDZKJsV6VaCqsfo8WH3e/MlW1c1ADdyiKE53pdyruOPn5Ul9cE3YPpmeRk0ZWGExYftWDfSjoo/byLPKVuwK3VPiP9z9VBM0oU7EfZakxd4S7LtWXUYcEq3kRxbkNsUoJcgTM5CQxQyPOg1mEcr6SYEhl7Dd+4YfRIyuvTg9wgHvBjw49AZE8572lQEcZzaraFHrPb4cFLIP5qCI//5WzD9qYS0c7g==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=envs.net; dkim=pass (4096-bit key; secure) header.d=envs.net header.i=@envs.net header.a=rsa-sha256 header.s=modoboa header.b=e69ccacw; dkim-atps=neutral; spf=pass (client-ip=157.180.15.194; helo=mail.envs.net; envelope-from=xtex@envs.net; receiver=lists.ozlabs.org) smtp.mailfrom=envs.net
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=envs.net
Authentication-Results: lists.ozlabs.org;
	dkim=pass (4096-bit key; secure) header.d=envs.net header.i=@envs.net header.a=rsa-sha256 header.s=modoboa header.b=e69ccacw;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=envs.net (client-ip=157.180.15.194; helo=mail.envs.net; envelope-from=xtex@envs.net; receiver=lists.ozlabs.org)
X-Greylist: delayed 370 seconds by postgrey-1.37 at boromir; Thu, 30 Apr 2026 22:16:01 AEST
Received: from mail.envs.net (mail.envs.net [157.180.15.194])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4g5tS12lsRz2xSG
	for <linux-erofs@lists.ozlabs.org>; Thu, 30 Apr 2026 22:16:01 +1000 (AEST)
Received: from localhost (mail.envs.net [127.0.0.1])
	by mail.envs.net (Postfix) with ESMTP id 2FB251C00C5
	for <linux-erofs@lists.ozlabs.org>; Thu, 30 Apr 2026 12:09:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=envs.net; s=modoboa;
	t=1777550987; bh=TpbMgWffqqFrHPlS/1tiVD+/g31u6U2o636RxeQBUNQ=;
	h=From:To:Subject:Date:From;
	b=e69ccacwsymjfbL1GEibgi1VrPKVKpeOW0PTbxlK4HhiEhzL0ikThxsOPxZBGNmpg
	 EyiV9N0vzJdtnBAAhM6dFGO/+vwOLSa1z4Gqui6FlEzP8BcMFe3dNilhqUAJ8fgcEx
	 BOjUfZcfiG9MNRlEbN2y4KzFmohIfyCaIXkCZvv64+1xcSZvleQNCxIAM38C+/lQv4
	 PUZhI/yb9xcPcKXnw78tZgyUG5jjPfxLHr+RE8BackV7fgo0KI9LImDp9o189Uq1sw
	 I0yzoa8Utz0m/0d3Km8uvZ8hI7n8v4SQuZDOUIsEuxrur2pomgjTuY1ko5/7hf4zOC
	 hYYmkbtCAM0xIkePoNC/bleuF6duj3m4SPu73qxkx//LeUurcHwjJ4+zxWlbMEsx9s
	 qoWey9QrYVFi4idc4HZbqRfIhDLNcPs2tAudS7yHuY27LDMiMMlVPUqhC4jqXTZrp0
	 8l7tCyEWm7b+c0p0xdJnaBwTvrjQiU4CwDciiIvL3JYl/Qzo3PEzL6WlGxlk09vnvQ
	 HD3TyDHOd0eAltEyb5zU7ARaGvVl7krwM46PrSwrB2uzf39mANQ7047XcEe+qgXias
	 HwR1Zqf2MRu+hWZ2R509EqHIJs2gaHKoDRxUD6HXseTIbHWvbEPJyIkJbjH7u5Bqe4
	 ba5Nt8Wm8tbdbp7sMMUAW/nU=
X-Virus-Scanned: Debian amavisd-new at mail.envs.net
Received: from mail.envs.net ([127.0.0.1])
	by localhost (mail.envs.net [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id tL8NJ905m5I8 for <linux-erofs@lists.ozlabs.org>;
	Thu, 30 Apr 2026 12:09:45 +0000 (UTC)
Received: from xtex1.localnet (unknown [89.251.11.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.envs.net (Postfix) with ESMTPSA
	for <linux-erofs@lists.ozlabs.org>; Thu, 30 Apr 2026 12:09:45 +0000 (UTC)
From: xtex <xtex@envs.net>
To: linux-erofs@lists.ozlabs.org
Subject: Rebuild mode for tail-pack layouts
Date: Thu, 30 Apr 2026 20:09:41 +0800
Message-ID: <Jk-rGy7vS2y1kZoygWQp8w@envs.net>
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
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"
X-Spam-Status: No, score=-0.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS autolearn=disabled
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org
X-Rspamd-Queue-Id: 1F44C4A2A7E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.70 / 15.00];
	ARC_ALLOW(-1.00)[lists.ozlabs.org:s=201707:i=1];
	DMARC_POLICY_ALLOW(-0.50)[envs.net,quarantine];
	CTE_CASE(0.50)[];
	R_DKIM_ALLOW(-0.20)[envs.net:s=modoboa];
	R_SPF_ALLOW(-0.20)[+ip4:112.213.38.117];
	MAILLIST(-0.19)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[envs.net:+];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_ONE(0.00)[1];
	MISSING_XM_UA(0.00)[];
	TAGGED_FROM(0.00)[bounces-3368-lists,linux-erofs=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_NONE(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[xtex@envs.net,linux-erofs@lists.ozlabs.org];
	ASN(0.00)[asn:133159, ipnet:112.213.32.0/21, country:AU];
	PREVIOUSLY_DELIVERED(0.00)[linux-erofs@lists.ozlabs.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-erofs];
	DBL_BLOCKED_OPENRESOLVER(0.00)[envs.net:dkim,envs.net:mid]

Hi!

In erofs_rebuild_write_blob_index (rebuild.c), only EROFS_INODE_CHUNK_BASED 
and FLAT_PLAIN are implemented, so when generating a metadata index with 
rebuild mode, the sources cannot use tail-pack nor inline data layout.
However, disabling tail-packing can lead to great disk-space waste in many 
cases, especially when the file-system consists of a lot of small files.

Thus I attempted to implement FLAT_INLINE for it, only to realize that the 
current chunk entry formats can only represent physical addresses that are 
block-aligned while tail-pack extent is not.

I wonder what do you think about adding a new chunk entry format? And how 
should it be named?

I would suggest the following structure:
struct erofs_inode_chunk_index_tp {
	__le16 startblk_hi;	/* starting block number MSB */
	__le16 device_id;	/* back-end storage id (with bits masked) 
*/
	__le32 startblk_lo;	/* starting block number of this chunk */
	/* new fields below */
	__le16 startblk_off;	/* starting block offset */
	__le16 reserved;
} __packed;
The 16b offset should be enough unless we are to support block size > 64K.
The reserved field is added for alignment.

Best wishes.

-- 
xtex (Bingwu Zhang, a.k.a Zerogawa Chiaki) @ Thu, 30 Apr 2026 11:45:17 +0000




