Return-Path: <linux-erofs+bounces-1294-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 78B22C11E27
	for <lists+linux-erofs@lfdr.de>; Mon, 27 Oct 2025 23:50:26 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4cwTHM20VCz303y;
	Tue, 28 Oct 2025 09:50:23 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=128.30.2.78
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1761605423;
	cv=none; b=KI6A952i0PdT7Nvd5KwM1rtCoK9qRynr/vO/7DhlZpxV133Q4RPkTGcCpyAiOacawYueVRuE5w2dJlJXump03effmyQDDaMIeKecB4Gk1J5TvVcq7WYIKVRRS9yd0rN2n0FmIGsCHCty319DSiWOlAMPxbqrwmECkyiJIy1a/JXExVnoqjFqAgk60TDAo9hRgJ86c3CPaxkrv5yy4+5g2s9GGO6/DqMXHCB+m5BiLy2zpKxg/V6L375QelC3WQ13NB87R3NYVL5qbl6so4irzwj2VI4B6ytwVijF7O4GFkOgnE4fcIiB5puMRSfmVsGc46SVVq5TrOz2UJ5nSryIvA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1761605423; c=relaxed/relaxed;
	bh=ZSYfX5K4el7seUdGhPgXPY7xoFXNYQipM3AWQcF+UlM=;
	h=To:cc:From:Subject:Date:Message-ID; b=CQ8qf2YxQNK6me821cHEmMgzkkVDoq6WkZlLSwit78zFYqbymbBJVTtXBPnf2pQ0rqAFD41x+S0IKv9nnFj50LP73phqD9JtDU3OsIkGxlH+okQzmUCFdpnb6yy/Am0ZBMcmpNRBcHKb9JxpesBdjLXzkF4FJX8sXi/E5qqp5oTanA++kt9Xx/QDnDDH/Q3ZSlvRnm62Feo0IjHLBMaULx5GKNABtWD6P03RM+bqHoDQnD9h13arWXJQpKMrCDSv6Ok0F36vopvrSq0eJ//3c3i79joJ4v35Jy4T18hKEq7/HtIaVlAOq7TunO3kmqW35XhUYZQ2ULtLb0+bt5zl0g==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=csail.mit.edu; dkim=pass (2048-bit key; unprotected) header.d=outgoing.csail.mit.edu header.i=@outgoing.csail.mit.edu header.a=rsa-sha256 header.s=test20231205 header.b=RQlbVPLP; dkim-atps=neutral; spf=pass (client-ip=128.30.2.78; helo=outgoing2021.csail.mit.edu; envelope-from=rtm@csail.mit.edu; receiver=lists.ozlabs.org) smtp.mailfrom=csail.mit.edu
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=csail.mit.edu
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=outgoing.csail.mit.edu header.i=@outgoing.csail.mit.edu header.a=rsa-sha256 header.s=test20231205 header.b=RQlbVPLP;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=csail.mit.edu (client-ip=128.30.2.78; helo=outgoing2021.csail.mit.edu; envelope-from=rtm@csail.mit.edu; receiver=lists.ozlabs.org)
Received: from outgoing2021.csail.mit.edu (outgoing2021.csail.mit.edu [128.30.2.78])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4cwTHJ4snXz2yFw
	for <linux-erofs@lists.ozlabs.org>; Tue, 28 Oct 2025 09:50:19 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=outgoing.csail.mit.edu; s=test20231205; h=Message-ID:Date:Subject:Reply-To:
	From:cc:To:Sender:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=ZSYfX5K4el7seUdGhPgXPY7xoFXNYQipM3AWQcF+UlM=; t=1761605420; x=1762469420; 
	b=RQlbVPLPq/YOw7GOdxMpRoLJHuVr4FdDkUu47HzEMntozh1KpWcR97ODs7EBkfbe9EVTTuSIsYG
	ucPHU1vGUKvX8AhXb+f9QQJZRq3DYMV79xMN7jmSqnLFHQsHGibi7pD3dYN3telfH1kNBtPTozYCe
	NXBU8+xzw3aCA5kTG/4+OItHVvjZEMiYGwHY0UoRqTajSVG8PWw4BYuUVcW/9a50yAogeaLnO/IKZ
	PUPn/CQmz2TaO+Jl9UcPZ1X+OaTD5a6FpEaDNw6OC4CQtFx6K65g22YDulSxXI3mK8IU2fnUsQGkc
	FRI4Vdrz5rMQqbykGD/c4LjEg7WdQKmS+Iig==;
Received: from [24.147.175.133] (helo=crash.local)
	by outgoing2021.csail.mit.edu with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.95)
	(envelope-from <rtm@csail.mit.edu>)
	id 1vDW2Y-000ORP-0c;
	Mon, 27 Oct 2025 18:50:14 -0400
Received: from localhost (localhost [127.0.0.1])
	by crash.local (Postfix) with ESMTP id 45BBC2B3CF61;
	Mon, 27 Oct 2025 18:50:13 -0400 (EDT)
To: Gao Xiang <xiang@kernel.org>, Chao Yu <chao@kernel.org>
cc: linux-erofs@lists.ozlabs.org
From: rtm@csail.mit.edu
Reply-To: rtm@csail.mit.edu
Subject: infinite loop in z_erofs_zstd_decompress()
Date: Mon, 27 Oct 2025 18:50:13 -0400
Message-ID: <50958.1761605413@localhost>
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

# uname -r
6.18.0-rc3-00011-g31772dcc6abc
# wget http://www.rtmrtm.org/rtm/erofs22a.img
# mount -t erofs -o loop erofs22a.img /mnt
# ls -l /mnt/x
...
BUG: soft lockup - CPU#8 stuck for 26s! [ls:1309]

The "do" loop in z_erofs_zstd_decompress() never quits; some
guesses about why:

 * in_buf.size and .pos indicate there is no more input available.

 * zstd_decompress_stream() returns 9 indicating that it would like
   more input.

 * z_erofs_stream_switch_bufs() does nothing, perhaps because
   rq->inputsize and rq->outputsize are both zero, but also
   returns err=0.

#0  0xffffffff806ddbd6 in z_erofs_zstd_decompress (rq=0xffffffc6002f3308, 
    pgpl=0xffffffc6002f3750) at fs/erofs/decompressor_zstd.c:178
#1  0xffffffff806dab54 in z_erofs_decompress_pcluster (err=0, 
    be=0xffffffc6002f3340) at fs/erofs/zdata.c:1308
#2  z_erofs_decompress_queue (io=io@entry=0xffffffc6002f35c8, 
    pagepool=pagepool@entry=0xffffffc6002f3750) at fs/erofs/zdata.c:1408
#3  0xffffffff806dba48 in z_erofs_runqueue (f=f@entry=0xffffffc6002f36e0, 
    rapages=rapages@entry=0) at fs/erofs/zdata.c:1804
#4  0xffffffff806dbf00 in z_erofs_read_folio (file=file@entry=0x0, 
    folio=folio@entry=0xffffffc500145140) at fs/erofs/zdata.c:1884
#5  0xffffffff8020adaa in filemap_read_folio (file=file@entry=0x0, 
    filler=filler@entry=0xffffffff806dbe6e <z_erofs_read_folio>, 
    folio=folio@entry=0xffffffc500145140) at mm/filemap.c:2444
#6  0xffffffff8020d66a in do_read_cache_folio (mapping=0xffffffd602488588, 
    index=index@entry=0, filler=0xffffffff806dbe6e <z_erofs_read_folio>, 
    filler@entry=0x0, file=0x0, gfp=1051840) at mm/filemap.c:4024
#7  0xffffffff8020d714 in read_cache_folio (mapping=<optimized out>, 
    index=index@entry=0, filler=filler@entry=0x0, file=<optimized out>)
    at mm/filemap.c:4056
#8  0xffffffff806d37ea in read_mapping_folio (file=<optimized out>, index=0, 
    mapping=<optimized out>) at ./include/linux/pagemap.h:999
#9  erofs_bread (buf=buf@entry=0xffffffc6002f3910, offset=0, 
    need_kmap=need_kmap@entry=true) at fs/erofs/data.c:40
#10 0xffffffff806d41a8 in erofs_find_target_block (
    target=target@entry=0xffffffc6002f3a00, dir=dir@entry=0xffffffd6024883f0, 
    name=name@entry=0xffffffc6002f39f0, 
    _ndirents=_ndirents@entry=0xffffffc6002f39ec) at fs/erofs/namei.c:103
#11 0xffffffff806d4440 in erofs_namei (dir=dir@entry=0xffffffd6024883f0, 
    name=name@entry=0xffffffd6025b88b0, nid=nid@entry=0xffffffc6002f3ab0, 
    d_type=d_type@entry=0xffffffc6002f3aac) at fs/erofs/namei.c:177
#12 0xffffffff806d4710 in erofs_lookup (flags=<optimized out>, 
    dentry=0xffffffd6025b8890, dir=0xffffffd6024883f0) at fs/erofs/namei.c:206
#13 erofs_lookup (dir=0xffffffd6024883f0, dentry=0xffffffd6025b8890, 
    flags=<optimized out>) at fs/erofs/namei.c:193
#14 0xffffffff802c575e in __lookup_slow (name=name@entry=0xffffffc6002f3bf8, 
    dir=dir@entry=0xffffffd6025b8620, flags=flags@entry=0) at fs/namei.c:1816
#15 0xffffffff802c8a10 in lookup_slow (flags=0, dir=0xffffffd6025b8620, 
    name=0xffffffc6002f3bf8) at fs/namei.c:1833
#16 walk_component (nd=0xffffffc6002f3be8, flags=1) at fs/namei.c:2151
#17 0xffffffff802c93c2 in lookup_last (nd=0xffffffc6002f3be8)
    at fs/namei.c:2660
#18 path_lookupat (nd=nd@entry=0xffffffc6002f3be8, flags=flags@entry=256, 
    path=path@entry=0xffffffc6002f3d28) at fs/namei.c:2684

Robert Morris
rtm@mit.edu

