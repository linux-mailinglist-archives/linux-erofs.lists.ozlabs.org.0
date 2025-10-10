Return-Path: <linux-erofs+bounces-1171-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 652EFBCEBFC
	for <lists+linux-erofs@lfdr.de>; Sat, 11 Oct 2025 01:26:00 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4ck2t6665mz2xlQ;
	Sat, 11 Oct 2025 10:25:50 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.100
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1760138750;
	cv=none; b=Rj691Mqh/D6ayTgSPAabE1S/2ofqYwLqwW8QnmspyQYypZpiNKHgfSdlCzwVxOtcPNJACmxQHvr0l65N0oIKXRLZzqIwBmteINfxa/O/S2FYM0SfWiZltZIaohl3rSkVawhjxDxeIzCATgNALq+LUolSgX49gNJonzIzofN1VCc5e3Jy4xm7VPC6xOuZUkYcFrp8Yo+D/E5x54ZAS+f69OWHrOXOk8xqDKy79QCZ2G4g4s5av3wuz7wxH16ogJljrvZ38Q3Qgi9uJxFCerIUBHf+nPbz1ra6ggGy6lcuxWXIu4/78hXkFLv993Piv+Z28YsaKJ58zzZHEam6RmLgrg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1760138750; c=relaxed/relaxed;
	bh=XPGohNm5xsq47e+dM1vqIVGsmstbItYvIkNWVuWt2Xc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=N0QtFSTZYMsg6n93Hx9yGdTDfdFmbhKWHZzOLWgrB98h0LH4PdzEfiynvXhNsiEKRGe+TNksvUwyW9D0y5XiaoLV/UFiOTDvszRY/eMI9yJE5AO+UKPRx4hTsgPzBRfYECkzWrPJbMm3EqOGiWB0mYEPT30apJRR8+yFKxEoPBPNXW4Y3w/SSCaAJpjbJXVxxLtreVcNn0HSh/UmEVpKHH6szwi0ETn3H/QfT6tyr7s/P5LW7q0iZ+HoyZi9Sb6I+y3qQBOnM40p882b2OKGVIQA6r/OQAiOr8kzviYFrfwBYamBkbTYJJHydJBiRppCs/YdgaS77aif/XlEy1MMlg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=EW3KNFd8; dkim-atps=neutral; spf=pass (client-ip=115.124.30.100; helo=out30-100.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=EW3KNFd8;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.100; helo=out30-100.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-100.freemail.mail.aliyun.com (out30-100.freemail.mail.aliyun.com [115.124.30.100])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4ck2t4697nz2xgp
	for <linux-erofs@lists.ozlabs.org>; Sat, 11 Oct 2025 10:25:47 +1100 (AEDT)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1760138743; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=XPGohNm5xsq47e+dM1vqIVGsmstbItYvIkNWVuWt2Xc=;
	b=EW3KNFd85UgEOcH4YsQq+gXl8iJHQ+0DEiyZMXrHom3piOf0OOj2iKdQBibXmBPjU+cWW2VtUJysj8+ZIq0tHu8nPXq3mwVTzwJSQBPQr6YxYHy/Gt+Z+Y0AbeG9rh15olf1q636xcVpdjgHiZb2f9frTBUi/6MgUun+w7sirnY=
Received: from 30.134.15.121(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WpuQtky_1760138741 cluster:ay36)
          by smtp.aliyun-inc.com;
          Sat, 11 Oct 2025 07:25:41 +0800
Message-ID: <72a2531c-5cba-480f-8430-a570657cf4c8@linux.alibaba.com>
Date: Sat, 11 Oct 2025 07:25:40 +0800
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
User-Agent: Mozilla Thunderbird
Subject: Re: z_erofs_fill_bio_vec() can read off the end of compressed_bvecs[]
To: rtm@csail.mit.edu, Gao Xiang <xiang@kernel.org>, Chao Yu <chao@kernel.org>
Cc: linux-erofs@lists.ozlabs.org
References: <80524.1760131149@localhost>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <80524.1760131149@localhost>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-15.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_DKIM_WL,
	USER_IN_DEF_SPF_WL autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org

Hi Robert,

On 2025/10/11 05:19, rtm@csail.mit.edu wrote:
> Here's an erofs filesystem that causes a crash:
> 
> # wget http://www.rtmrtm.org/rtm/erofs7a.img
> # mount -t erofs -o loop erofs7a.img /mnt
> # cp /mnt/x /tmp/y
> Oops: general protection fault, probably for non-canonical address 0xccccccccccccccd4: 0000 [#1] SMP DEBUG_PAGEALLOC PTI
> CPU: 5 UID: 0 PID: 1449 Comm: cp Not tainted 6.17.0-12747-g859be217ee9e #35 PREEMPT(voluntary)
> Hardware name: FreeBSD BHYVE/BHYVE, BIOS 14.0 10/17/2021
> RIP: 0010:z_erofs_runqueue+0x61f/0xc00
> 
> My understanding of what leads to the crash:
> 
> z_erofs_fill_inode() reads a z_erofs_map_header whose h->h_advise
> is 1, causing vi->z_advise also to be 1.
> 
> z_advise=1 has EXTRECSZ bits that are all zeroes, so that this in
> z_erofs_map_blocks_ext() yields recsz = 4:
> 
>          unsigned int recsz = z_erofs_extent_recsize(vi->z_advise);
> 
> With recsz = 4, z_erofs_map_blocks_ext() reads 8 bytes of pa from ext
> even though I think only the first recsz=4 bytes are valid; perhaps the
> second "if" isn't quite right:
> 
>          if (recsz <= offsetof(struct z_erofs_extent, pstart_hi)) {
>                  if (recsz <= offsetof(struct z_erofs_extent, pstart_lo)) {
>                          ext = erofs_read_metabuf(&map->buf, sb, pos, in_mbox);
>                          if (IS_ERR(ext))
>                                  return PTR_ERR(ext);
>                          pa = le64_to_cpu(*(__le64 *)ext);
> 
> In the demo filesystem image, the 2nd 4 bytes are 0xffffffff, so pa
> ends up 0xffffffffffdcffed.

Thanks for the report!

In the new encoded extents (kernel >= 6.15), if recsz == 4, it will
start with 8-byte physical offset and then follows compressed length
so I think this part is correct.

In other words, we have to handle the new 64-bit 0xffffffffffdcffed
physical offset.

> 
> A bit later map->m_pa is set to this invalid pa:
> 
>                                  map->m_pa = pa;
> 
> Then in z_erofs_submit_queue() this map->m_pa results in huge cur and
> end values:
> 
>                  cur = mdev.m_pa;
>                  end = round_up(cur + pcl->pageofs_in + pcl->pclustersize,
>                                 sb->s_blocksize);

The issue I think is due to an overflowed calculation somewhere, let
me try to investigate more to bail out the overflowed case.

Thanks,
Gao Xiang

> 
> As a result the inner do loop runs for too many iterations, causing
> "i" to eventually run off the end of pcl->compressed_bvecs[] in
> z_erofs_fill_bio_vec(), so that zbv.page is not a valid pointer.
> 
> Here's a backtrace at the point of the crash:
> 
> #0  z_erofs_fill_bio_vec (mc=0xffffffd6024881e8, nr=257,
>      pcl=0xffffffd6027d8008, f=0xffffffc6002eb6e0, bvec=<synthetic pointer>)
>      at fs/erofs/zdata.c:1522
> #1  z_erofs_submit_queue (readahead=<optimized out>,
>      force_fg=<synthetic pointer>, fgq=0xffffffc6002eb5c8, f=0xffffffc6002eb6e0)
>      at fs/erofs/zdata.c:1751
> #2  z_erofs_runqueue (f=f@entry=0xffffffc6002eb6e0, rapages=rapages@entry=0)
>      at fs/erofs/zdata.c:1832
> #3  0xffffffff806db358 in z_erofs_read_folio (file=file@entry=0x0,
>      folio=folio@entry=0xffffffc5001459c0) at fs/erofs/zdata.c:1915
> #4  0xffffffff8020a45e in filemap_read_folio (file=file@entry=0x0,
>      filler=filler@entry=0xffffffff806db2c6 <z_erofs_read_folio>,
>      folio=folio@entry=0xffffffc5001459c0) at mm/filemap.c:2444
> #5  0xffffffff8020cd1e in do_read_cache_folio (mapping=0xffffffd602488588,
>      index=index@entry=0, filler=0xffffffff806db2c6 <z_erofs_read_folio>,
>      filler@entry=0x0, file=0x0, gfp=1051840) at mm/filemap.c:4024
> #6  0xffffffff8020cdc8 in read_cache_folio (mapping=<optimized out>,
>      index=index@entry=0, filler=filler@entry=0x0, file=<optimized out>)
>      at mm/filemap.c:4056
> #7  0xffffffff806d2dae in read_mapping_folio (file=<optimized out>, index=0,
>      mapping=<optimized out>) at ./include/linux/pagemap.h:999
> #8  erofs_bread (buf=buf@entry=0xffffffc6002eb910, offset=1536,
>      need_kmap=need_kmap@entry=true) at fs/erofs/data.c:40
> #9  0xffffffff806d376c in erofs_find_target_block (
>      target=target@entry=0xffffffc6002eba00, dir=dir@entry=0xffffffd6024883f0,
>      name=name@entry=0xffffffc6002eb9f0,
>      _ndirents=_ndirents@entry=0xffffffc6002eb9ec) at fs/erofs/namei.c:103
> #10 0xffffffff806d3a04 in erofs_namei (dir=dir@entry=0xffffffd6024883f0,
>      name=name@entry=0xffffffd6025a88b0, nid=nid@entry=0xffffffc6002ebab0,
>      d_type=d_type@entry=0xffffffc6002ebaac) at fs/erofs/namei.c:177
> #11 0xffffffff806d3cd4 in erofs_lookup (flags=<optimized out>,
>      dentry=0xffffffd6025a8890, dir=0xffffffd6024883f0) at fs/erofs/namei.c:206
> #12 erofs_lookup (dir=0xffffffd6024883f0, dentry=0xffffffd6025a8890,
>      flags=<optimized out>) at fs/erofs/namei.c:193
> #13 0xffffffff802c4bda in __lookup_slow (name=name@entry=0xffffffc6002ebbf8,
>      dir=dir@entry=0xffffffd6025b7620, flags=flags@entry=1) at fs/namei.c:1816
> #14 0xffffffff802c7e8c in lookup_slow (flags=1, dir=0xffffffd6025b7620,
>      name=0xffffffc6002ebbf8) at fs/namei.c:1833
> #15 walk_component (nd=0xffffffc6002ebbe8, flags=1) at fs/namei.c:2151
> #16 0xffffffff802c883e in lookup_last (nd=0xffffffc6002ebbe8)
>      at fs/namei.c:2660
> #17 path_lookupat (nd=nd@entry=0xffffffc6002ebbe8, flags=flags@entry=257,
>      path=path@entry=0xffffffc6002ebd28) at fs/namei.c:2684
> #18 0xffffffff802c8d58 in filename_lookup (dfd=dfd@entry=-100,
>      name=name@entry=0xffffffd602818040, flags=flags@entry=1,
>      path=path@entry=0xffffffc6002ebd28, root=root@entry=0x0) at fs/namei.c:2713
> #19 0xffffffff802be406 in vfs_statx (dfd=dfd@entry=-100,
>      filename=filename@entry=0xffffffd602818040, flags=flags@entry=2048,
>      stat=stat@entry=0xffffffc6002ebdc8, request_mask=request_mask@entry=2047)
>      at fs/stat.c:353
> #20 0xffffffff802be6e6 in vfs_fstatat (dfd=-100, filename=<optimized out>,
>      stat=0xffffffc6002ebdc8, flags=<optimized out>) at fs/stat.c:375
> #21 0xffffffff802be73a in __do_sys_newfstatat (dfd=<optimized out>,
>      filename=<optimized out>, statbuf=0x3ffffff660, flag=<optimized out>)
>      at fs/stat.c:542
> #22 0xffffffff802be77c in __se_sys_newfstatat (flag=<optimized out>,
>      statbuf=<optimized out>, filename=<optimized out>, dfd=<optimized out>)
>      at fs/stat.c:536
> #23 __riscv_sys_newfstatat (regs=<optimized out>) at fs/stat.c:536
> #24 0xffffffff81070d7e in syscall_handler (syscall=<optimized out>,
>      regs=0xffffffc6002ebee0) at ./arch/riscv/include/asm/syscall.h:112
> #25 do_trap_ecall_u (regs=0xffffffc6002ebee0) at arch/riscv/kernel/traps.c:343
> #26 0xffffffff8107d6ce in handle_exception () at arch/riscv/kernel/entry.S:198
> 
> (gdb) print nr
> $1 = 257
> (gdb) print zbv
> $2 = {page = 0xcccccccccccccccc, offset = 41783592, end = 4294967254}
> 
> Robert Morris
> rtm@mit.edu
> 


