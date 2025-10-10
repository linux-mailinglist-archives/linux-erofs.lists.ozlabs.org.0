Return-Path: <linux-erofs+bounces-1169-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6273EBCE9A2
	for <lists+linux-erofs@lfdr.de>; Fri, 10 Oct 2025 23:19:21 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4ck0465xHqz2xnk;
	Sat, 11 Oct 2025 08:19:18 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=128.30.2.78
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1760131158;
	cv=none; b=bL1+Asdcv0TeZQ1LdIRhbHc8kazxUcSqWkpvvmfamyV+tV969S4ZG/ZGxBcuMt+T1i0RLugQTLsZAMLRyI0M+AkYg4+MvsfcE9aHCP612XVKgsE4sR6Aut2SJ+rXK1uzl1vWO0d/RtzedCoysG5uj4Mzz/BrCR8eLeqMlnWPZa4yhEoj1dIfm5BDLIs1uMBZbBbsXarkQX+2HQecvcTufuguulfipZrjShZ4mbrrBBUHW6SQlx2ofuhv1p4wD6PHHFXf58F5Mbu0rJ4sGEsxsVvmTy3KQXgtYszYWPHUbm7OqnH52Ntee3ZHxd8hPkQhMIGdP1k2o/nbXJ4DKZepcg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1760131158; c=relaxed/relaxed;
	bh=fATtBOdMsnwdKehi5CG88RQ4ssDjXBg3/303q/7W9LE=;
	h=To:cc:From:Subject:Date:Message-ID; b=EdXfkvgpqNF9SJEUcT4rR7JoL4XA/kGFpv4e9/wML5vd+ultgIVMJbGAsA1AiHxIutV8kpT66gseJVSADGguaCt0/S5nn6GKdc9/BSgLcoSamUq11G+3fRALMKzOH60g/dyE27FF8KNS3zes/ouc+GEyuHujr54/N5X1b2zSB5jyz/rZywTPeExtzjHtfgwYVwbK3hN/mQjGOGwUrmbGUnVHGyrwVd7QqvUFDP48/mpHGbpNkDSG+Mlkjekh+Dk3jn2XAl7+6m8l6dKdZwuv3dwncZq13Z/2Qn2EmzeGYeQnCEBLO+4HFCt+DlvbaoX66BgCMRDqnaTefs3BBT55eg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=csail.mit.edu; dkim=pass (2048-bit key; unprotected) header.d=outgoing.csail.mit.edu header.i=@outgoing.csail.mit.edu header.a=rsa-sha256 header.s=test20231205 header.b=V5xGovlV; dkim-atps=neutral; spf=pass (client-ip=128.30.2.78; helo=outgoing2021.csail.mit.edu; envelope-from=rtm@csail.mit.edu; receiver=lists.ozlabs.org) smtp.mailfrom=csail.mit.edu
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=csail.mit.edu
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=outgoing.csail.mit.edu header.i=@outgoing.csail.mit.edu header.a=rsa-sha256 header.s=test20231205 header.b=V5xGovlV;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=csail.mit.edu (client-ip=128.30.2.78; helo=outgoing2021.csail.mit.edu; envelope-from=rtm@csail.mit.edu; receiver=lists.ozlabs.org)
Received: from outgoing2021.csail.mit.edu (outgoing2021.csail.mit.edu [128.30.2.78])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4ck0442tJ4z2xlQ
	for <linux-erofs@lists.ozlabs.org>; Sat, 11 Oct 2025 08:19:15 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=outgoing.csail.mit.edu; s=test20231205; h=Message-ID:Date:Subject:Reply-To:
	From:cc:To:Sender:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=fATtBOdMsnwdKehi5CG88RQ4ssDjXBg3/303q/7W9LE=; t=1760131156; x=1760995156; 
	b=V5xGovlV+gFLM4Tn4C1WQiM6tK8ZPov2VvF6vgxOgNWvoscfNuTiHg12bAoqdboTmCTUg54asrg
	P71wB/ZKJhaKYN95MI/RsyCcehQoGIQxE4daMFPSSjQfMUvELey8MBYzlVk0/JdtYbR1YUY7TI+4L
	kk8XrnxnDgKdRmb6tdzqinhjs6VoqCyE9dePcao0d7P/ao90YpIltpvqprCs2UuFFX15b3IQUdvYe
	z7JKJBT8ulfpm3UXEiKylSseOJhSaTV7MMtOed7vx0jGU2DgTgCTaBDJhs8EUGMTz4m4QYwE1JWLx
	DwyxFA4vLkmr6LZ02/3lkv/XUbFjlYBI+YBA==;
Received: from [24.147.175.133] (helo=crash.local)
	by outgoing2021.csail.mit.edu with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.95)
	(envelope-from <rtm@csail.mit.edu>)
	id 1v7KW6-005e8d-PJ;
	Fri, 10 Oct 2025 17:19:10 -0400
Received: from localhost (localhost [127.0.0.1])
	by crash.local (Postfix) with ESMTP id DEADF2A4EE8D;
	Fri, 10 Oct 2025 17:19:09 -0400 (EDT)
To: Gao Xiang <xiang@kernel.org>, Chao Yu <chao@kernel.org>
cc: linux-erofs@lists.ozlabs.org
From: rtm@csail.mit.edu
Reply-To: rtm@csail.mit.edu
Subject: z_erofs_fill_bio_vec() can read off the end of compressed_bvecs[]
Date: Fri, 10 Oct 2025 17:19:09 -0400
Message-ID: <80524.1760131149@localhost>
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

Here's an erofs filesystem that causes a crash:

# wget http://www.rtmrtm.org/rtm/erofs7a.img
# mount -t erofs -o loop erofs7a.img /mnt
# cp /mnt/x /tmp/y
Oops: general protection fault, probably for non-canonical address 0xccccccccccccccd4: 0000 [#1] SMP DEBUG_PAGEALLOC PTI
CPU: 5 UID: 0 PID: 1449 Comm: cp Not tainted 6.17.0-12747-g859be217ee9e #35 PREEMPT(voluntary)
Hardware name: FreeBSD BHYVE/BHYVE, BIOS 14.0 10/17/2021
RIP: 0010:z_erofs_runqueue+0x61f/0xc00

My understanding of what leads to the crash:

z_erofs_fill_inode() reads a z_erofs_map_header whose h->h_advise
is 1, causing vi->z_advise also to be 1. 

z_advise=1 has EXTRECSZ bits that are all zeroes, so that this in
z_erofs_map_blocks_ext() yields recsz = 4:

        unsigned int recsz = z_erofs_extent_recsize(vi->z_advise);

With recsz = 4, z_erofs_map_blocks_ext() reads 8 bytes of pa from ext
even though I think only the first recsz=4 bytes are valid; perhaps the
second "if" isn't quite right:

        if (recsz <= offsetof(struct z_erofs_extent, pstart_hi)) {
                if (recsz <= offsetof(struct z_erofs_extent, pstart_lo)) {
                        ext = erofs_read_metabuf(&map->buf, sb, pos, in_mbox);
                        if (IS_ERR(ext))
                                return PTR_ERR(ext);
                        pa = le64_to_cpu(*(__le64 *)ext);

In the demo filesystem image, the 2nd 4 bytes are 0xffffffff, so pa
ends up 0xffffffffffdcffed.

A bit later map->m_pa is set to this invalid pa:

                                map->m_pa = pa;

Then in z_erofs_submit_queue() this map->m_pa results in huge cur and
end values:

                cur = mdev.m_pa;
                end = round_up(cur + pcl->pageofs_in + pcl->pclustersize,
                               sb->s_blocksize);

As a result the inner do loop runs for too many iterations, causing
"i" to eventually run off the end of pcl->compressed_bvecs[] in
z_erofs_fill_bio_vec(), so that zbv.page is not a valid pointer.

Here's a backtrace at the point of the crash:

#0  z_erofs_fill_bio_vec (mc=0xffffffd6024881e8, nr=257, 
    pcl=0xffffffd6027d8008, f=0xffffffc6002eb6e0, bvec=<synthetic pointer>)
    at fs/erofs/zdata.c:1522
#1  z_erofs_submit_queue (readahead=<optimized out>, 
    force_fg=<synthetic pointer>, fgq=0xffffffc6002eb5c8, f=0xffffffc6002eb6e0)
    at fs/erofs/zdata.c:1751
#2  z_erofs_runqueue (f=f@entry=0xffffffc6002eb6e0, rapages=rapages@entry=0)
    at fs/erofs/zdata.c:1832
#3  0xffffffff806db358 in z_erofs_read_folio (file=file@entry=0x0, 
    folio=folio@entry=0xffffffc5001459c0) at fs/erofs/zdata.c:1915
#4  0xffffffff8020a45e in filemap_read_folio (file=file@entry=0x0, 
    filler=filler@entry=0xffffffff806db2c6 <z_erofs_read_folio>, 
    folio=folio@entry=0xffffffc5001459c0) at mm/filemap.c:2444
#5  0xffffffff8020cd1e in do_read_cache_folio (mapping=0xffffffd602488588, 
    index=index@entry=0, filler=0xffffffff806db2c6 <z_erofs_read_folio>, 
    filler@entry=0x0, file=0x0, gfp=1051840) at mm/filemap.c:4024
#6  0xffffffff8020cdc8 in read_cache_folio (mapping=<optimized out>, 
    index=index@entry=0, filler=filler@entry=0x0, file=<optimized out>)
    at mm/filemap.c:4056
#7  0xffffffff806d2dae in read_mapping_folio (file=<optimized out>, index=0, 
    mapping=<optimized out>) at ./include/linux/pagemap.h:999
#8  erofs_bread (buf=buf@entry=0xffffffc6002eb910, offset=1536, 
    need_kmap=need_kmap@entry=true) at fs/erofs/data.c:40
#9  0xffffffff806d376c in erofs_find_target_block (
    target=target@entry=0xffffffc6002eba00, dir=dir@entry=0xffffffd6024883f0, 
    name=name@entry=0xffffffc6002eb9f0, 
    _ndirents=_ndirents@entry=0xffffffc6002eb9ec) at fs/erofs/namei.c:103
#10 0xffffffff806d3a04 in erofs_namei (dir=dir@entry=0xffffffd6024883f0, 
    name=name@entry=0xffffffd6025a88b0, nid=nid@entry=0xffffffc6002ebab0, 
    d_type=d_type@entry=0xffffffc6002ebaac) at fs/erofs/namei.c:177
#11 0xffffffff806d3cd4 in erofs_lookup (flags=<optimized out>, 
    dentry=0xffffffd6025a8890, dir=0xffffffd6024883f0) at fs/erofs/namei.c:206
#12 erofs_lookup (dir=0xffffffd6024883f0, dentry=0xffffffd6025a8890, 
    flags=<optimized out>) at fs/erofs/namei.c:193
#13 0xffffffff802c4bda in __lookup_slow (name=name@entry=0xffffffc6002ebbf8, 
    dir=dir@entry=0xffffffd6025b7620, flags=flags@entry=1) at fs/namei.c:1816
#14 0xffffffff802c7e8c in lookup_slow (flags=1, dir=0xffffffd6025b7620, 
    name=0xffffffc6002ebbf8) at fs/namei.c:1833
#15 walk_component (nd=0xffffffc6002ebbe8, flags=1) at fs/namei.c:2151
#16 0xffffffff802c883e in lookup_last (nd=0xffffffc6002ebbe8)
    at fs/namei.c:2660
#17 path_lookupat (nd=nd@entry=0xffffffc6002ebbe8, flags=flags@entry=257, 
    path=path@entry=0xffffffc6002ebd28) at fs/namei.c:2684
#18 0xffffffff802c8d58 in filename_lookup (dfd=dfd@entry=-100, 
    name=name@entry=0xffffffd602818040, flags=flags@entry=1, 
    path=path@entry=0xffffffc6002ebd28, root=root@entry=0x0) at fs/namei.c:2713
#19 0xffffffff802be406 in vfs_statx (dfd=dfd@entry=-100, 
    filename=filename@entry=0xffffffd602818040, flags=flags@entry=2048, 
    stat=stat@entry=0xffffffc6002ebdc8, request_mask=request_mask@entry=2047)
    at fs/stat.c:353
#20 0xffffffff802be6e6 in vfs_fstatat (dfd=-100, filename=<optimized out>, 
    stat=0xffffffc6002ebdc8, flags=<optimized out>) at fs/stat.c:375
#21 0xffffffff802be73a in __do_sys_newfstatat (dfd=<optimized out>, 
    filename=<optimized out>, statbuf=0x3ffffff660, flag=<optimized out>)
    at fs/stat.c:542
#22 0xffffffff802be77c in __se_sys_newfstatat (flag=<optimized out>, 
    statbuf=<optimized out>, filename=<optimized out>, dfd=<optimized out>)
    at fs/stat.c:536
#23 __riscv_sys_newfstatat (regs=<optimized out>) at fs/stat.c:536
#24 0xffffffff81070d7e in syscall_handler (syscall=<optimized out>, 
    regs=0xffffffc6002ebee0) at ./arch/riscv/include/asm/syscall.h:112
#25 do_trap_ecall_u (regs=0xffffffc6002ebee0) at arch/riscv/kernel/traps.c:343
#26 0xffffffff8107d6ce in handle_exception () at arch/riscv/kernel/entry.S:198

(gdb) print nr
$1 = 257
(gdb) print zbv
$2 = {page = 0xcccccccccccccccc, offset = 41783592, end = 4294967254}

Robert Morris
rtm@mit.edu


