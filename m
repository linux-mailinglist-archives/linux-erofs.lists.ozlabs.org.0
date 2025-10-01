Return-Path: <linux-erofs+bounces-1151-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id D9960BB1F21
	for <lists+linux-erofs@lfdr.de>; Thu, 02 Oct 2025 00:10:12 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4ccTcx28VPz2yrP;
	Thu,  2 Oct 2025 08:10:09 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=128.30.2.78
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1759356609;
	cv=none; b=F4KpmnOyypRgKZ3W+iYSYbT+LOeq5jrYF3qfGGyG2gN5sOTNLtuS92YB7h+Dzg2RiOwn82fk8zTHFCjti1Y/tcPCfBuBVoEd3JhccNhuR6oPFkZ02wCzmi+TnRyvtnZGoJji+jMDhjWz9Ax6KC5xYkvh4TZokGrTI1AstzTlwLx/HSIk4/esgfz3Q5NF1ornKhzKWPnws3Nmm0C49i3i9imw8KLzcEwbMgSWLHXl3xm9adbgunBvnTqdDeJa4Ifsm+LOsw7nwFm+e6UCfhassYwCPb64HZv0pdknqiq6HvD1ZrohC/TZdCnv0rMPvdFnSNz0nWvkpgxRQ+4TxXd5KQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1759356609; c=relaxed/relaxed;
	bh=vfRDx31gBt7rl/UoYLFTl2HV0dCyvAEXn+pTR6C7o/w=;
	h=To:cc:From:Subject:Date:Message-ID; b=NLYsQ1cNMgK3ZjzJuB1gSj9qckGm1Y5GmuWscieRTB9yMbsXZ2XufT6ziv25hq8zbhVs02LkI6Wj8fvh9n7ljy5vV6D3AkWTBqT5/7IvX4s+HQRPizyKtwvpQ4yTK/k4dIerkSUJDXH24yhVHjQhKyky/KPKNK+jy7nMUEpZrNMp/VecyZRRcVNcWYLY/6CgjzasYqDmm/FyyiDKBOkEFl5OUtdrK3jIIXOJRub1+N4iPZy6dqj9ThlhRzp8wdIHQovFry8y9L0PyhN+jDZE9Cxqw7vY0YFEklIKgKh57p2+6wficZV4zmrkyJqWdRvH9sRjHoDFnWDzJ1MLHXIxIw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=csail.mit.edu; dkim=pass (2048-bit key; unprotected) header.d=outgoing.csail.mit.edu header.i=@outgoing.csail.mit.edu header.a=rsa-sha256 header.s=test20231205 header.b=bTDs5LOX; dkim-atps=neutral; spf=pass (client-ip=128.30.2.78; helo=outgoing2021.csail.mit.edu; envelope-from=rtm@csail.mit.edu; receiver=lists.ozlabs.org) smtp.mailfrom=csail.mit.edu
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=csail.mit.edu
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=outgoing.csail.mit.edu header.i=@outgoing.csail.mit.edu header.a=rsa-sha256 header.s=test20231205 header.b=bTDs5LOX;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=csail.mit.edu (client-ip=128.30.2.78; helo=outgoing2021.csail.mit.edu; envelope-from=rtm@csail.mit.edu; receiver=lists.ozlabs.org)
X-Greylist: delayed 771 seconds by postgrey-1.37 at boromir; Thu, 02 Oct 2025 08:10:06 AEST
Received: from outgoing2021.csail.mit.edu (outgoing2021.csail.mit.edu [128.30.2.78])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4ccTct66rtz2ywC
	for <linux-erofs@lists.ozlabs.org>; Thu,  2 Oct 2025 08:10:06 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=outgoing.csail.mit.edu; s=test20231205; h=Message-ID:Date:Subject:Reply-To:
	From:cc:To:Sender:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=vfRDx31gBt7rl/UoYLFTl2HV0dCyvAEXn+pTR6C7o/w=; t=1759356606; x=1760220606; 
	b=bTDs5LOXXuUNdVTHCaRJVbi+C7f1o0+yap4yingmdM80CxZfeSKlzwFh3bLAQ9A87+o7yDL5pEs
	tMhxpUjxdVt4mWDtzFvE81cbjSS+UAq08ijmRqaaHhcwOpQYRiJNwRq0GFQXT3BxdjRNPXp6MilDz
	+AKOdUbVLDXV5W9Ns0lGuCdxZBdVGFV/8RkdmQjVRFGfILVnEkgt+DL86Pm2lFI6QdsnAVRKST2iR
	N0mZyyAo7ncMfrSieSgGO3yKGhUtM9lFjWPYEpNUcw6lpwLfHRGWFpnXqVk/naCCcYUocYHWSNIR/
	j3P2CMTKaQRVedZ/tWq7JFdmuloU0HQNTlkg==;
Received: from [24.147.175.133] (helo=crash.local)
	by outgoing2021.csail.mit.edu with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.95)
	(envelope-from <rtm@csail.mit.edu>)
	id 1v44ox-00Ff0s-3y;
	Wed, 01 Oct 2025 17:57:11 -0400
Received: from localhost (localhost [127.0.0.1])
	by crash.local (Postfix) with ESMTP id 3E42129D3912;
	Wed, 01 Oct 2025 17:57:10 -0400 (EDT)
To: Gao Xiang <xiang@kernel.org>, Chao Yu <chao@kernel.org>
cc: linux-erofs@lists.ozlabs.org
From: rtm@csail.mit.edu
Reply-To: rtm@csail.mit.edu
Subject: z_erofs_extent.plen == 0x2000000 can lead to crash
Date: Wed, 01 Oct 2025 17:57:10 -0400
Message-ID: <75022.1759355830@localhost>
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=disabled
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org
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

Here's a corrupt erofs image that can cause a crash:

# wget http://www.rtmrtm.org/rtm/erofs4a.img
# mount -t erofs -o loop erofs4a.img /mnt
# cat < /mnt/d/y > /dev/null
 kernel BUG at block/blk-mq.c:1152!
 Oops: invalid opcode: 0000 [#1] SMP PTI
 CPU: 11 UID: 0 PID: 1315 Comm: cat Not tainted 6.17.0-01737-g50c19e20ed2e #29 PREEMPT(voluntary)
 Hardware name: FreeBSD BHYVE/BHYVE, BIOS 14.0 10/17/2021
 RIP: 0010:blk_mq_end_request+0x28/0x30

The problem is that the inner "do" loop of z_erofs_submit_queue() runs
without bound submitting read requests, because bvec.bv_len is zero.
The reason for the zero is that the broken filesystem image contains
an z_erofs_extent.plen of 0x2000000. This looks non-zero to the

        } else if (map->m_plen) {

in z_erofs_map_blocks_ext(), but then the code does

                        map->m_plen &= Z_EROFS_EXTENT_PLEN_MASK;

causing m_plen to be zero.

If CONFIG_EROFS_FS_DEBUG, the problem is caught by
z_erofs_submit_queue()'s

                                DBG_BUGON(bvec.bv_len < sb->s_blocksize);

Robert Morris
rtm@mit.edu


