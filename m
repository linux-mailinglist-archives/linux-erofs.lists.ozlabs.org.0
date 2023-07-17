Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 029B27562FE
	for <lists+linux-erofs@lfdr.de>; Mon, 17 Jul 2023 14:44:45 +0200 (CEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=jQ45nUFP;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=jQ45nUFP;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4R4MGy6Hxdz2yGJ
	for <lists+linux-erofs@lfdr.de>; Mon, 17 Jul 2023 22:44:42 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=jQ45nUFP;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=jQ45nUFP;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=redhat.com (client-ip=170.10.129.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=dwysocha@redhat.com; receiver=lists.ozlabs.org)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4R4MGv0VcDz2yD4
	for <linux-erofs@lists.ozlabs.org>; Mon, 17 Jul 2023 22:44:38 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1689597873;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cPBr5P6RMAc5J6eRrRxygG6j4FumvyTiuWHqCKdLMWY=;
	b=jQ45nUFPjs0qrFLJVbtRr3aQ94aW0xMedsh/uf7W6YWKN6K9TPu0KCDdDvaZMvAOfuLmSE
	0do0+jiyx0AIKgiRO+3b0p9bOk0z+kikQixX8RCJZA4DJ4Bcnzm6zJxf+pB6k9SPDDb+bC
	NLcvx9x2yoePB2OOuoOlut3r6y9/Fto=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1689597873;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cPBr5P6RMAc5J6eRrRxygG6j4FumvyTiuWHqCKdLMWY=;
	b=jQ45nUFPjs0qrFLJVbtRr3aQ94aW0xMedsh/uf7W6YWKN6K9TPu0KCDdDvaZMvAOfuLmSE
	0do0+jiyx0AIKgiRO+3b0p9bOk0z+kikQixX8RCJZA4DJ4Bcnzm6zJxf+pB6k9SPDDb+bC
	NLcvx9x2yoePB2OOuoOlut3r6y9/Fto=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-651-yW6-Ww-cP7KCez2Gb287ow-1; Mon, 17 Jul 2023 08:44:31 -0400
X-MC-Unique: yW6-Ww-cP7KCez2Gb287ow-1
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-262d505f44cso1979548a91.1
        for <linux-erofs@lists.ozlabs.org>; Mon, 17 Jul 2023 05:44:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689597867; x=1692189867;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cPBr5P6RMAc5J6eRrRxygG6j4FumvyTiuWHqCKdLMWY=;
        b=bQhf4X1sIMy2IYF4zCbYPlPl7jsS+myuORh2PZ3POGYVFTj+KfrzMdbGTHrri2IMnZ
         Cwt28QdybsNOa3tDK3yFK2nhRFA9Fj4eq16ez5lQ4KI7pQB+dArxqcDvPzZydP/+gvZE
         e775KDWJX8U8+yiNJby0UVi/ojwiY9Oqp1Mhc1/c/fHO2pyQntW3wvfi71UVZ+5veGY2
         o+IO6OTQC0DlfL0WCGhrQjQRcSSaeoKpK+9/xDmiber6+BFTVwHeMfyPnBevQgbk3xBn
         cCWuM2SC2kDXfg5heSAWHYWYGKD1Q79ac8W3J9mKYV4t1oY+m4H+nUjNCW0f5oqrsnn4
         lZQg==
X-Gm-Message-State: ABy/qLYJNZhgtNkqmA4FNFBInI7Frxe7h4JPdhxsnh1fA5mPbs8WnNxL
	jWJi1pi/kfezDIOKavc7+dl7ldS//fZ5E/AxguqoiTIeSC0DPa26Xt4s/ONXLvth/dzQ+ks3xGY
	JzHK3Ob6yBZ5Pl/x2/CwOzHSEgWprZ2V+NUXm7g+v
X-Received: by 2002:a17:90a:5902:b0:263:ea6a:1049 with SMTP id k2-20020a17090a590200b00263ea6a1049mr10021669pji.2.1689597867203;
        Mon, 17 Jul 2023 05:44:27 -0700 (PDT)
X-Google-Smtp-Source: APBJJlHasnKG+SNiDONa+CP1OSdvJTohPXX69WzDE7nIpw5fYJbI1G9ilrC2Cj9qoIe3xkPsQOURqnSvBH8qP+XIJY0=
X-Received: by 2002:a17:90a:5902:b0:263:ea6a:1049 with SMTP id
 k2-20020a17090a590200b00263ea6a1049mr10021649pji.2.1689597866936; Mon, 17 Jul
 2023 05:44:26 -0700 (PDT)
MIME-Version: 1.0
References: <20230628104852.3391651-3-dhowells@redhat.com> <202307171548.7ab20146-oliver.sang@intel.com>
In-Reply-To: <202307171548.7ab20146-oliver.sang@intel.com>
From: David Wysochanski <dwysocha@redhat.com>
Date: Mon, 17 Jul 2023 08:43:50 -0400
Message-ID: <CALF+zOm5RuFSkd=KNxh+-vF+2SNsgP7s-WVrwHxVxxLrS6NtxQ@mail.gmail.com>
Subject: Re: [PATCH v7 2/2] mm, netfs, fscache: Stop read optimisation when
 folio removed from pagecache
To: kernel test robot <oliver.sang@intel.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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
Cc: Jeff Layton <jlayton@kernel.org>, Dominique Martinet <asmadeus@codewreck.org>, David Howells <dhowells@redhat.com>, linux-mm@kvack.org, linux-afs@lists.infradead.org, Shyam Prasad N <nspmangalore@gmail.com>, linux-cifs@vger.kernel.org, lkp@intel.com, Matthew Wilcox <willy@infradead.org>, Christoph Hellwig <hch@infradead.org>, linux-cachefs@redhat.com, v9fs-developer@lists.sourceforge.net, Ilya Dryomov <idryomov@gmail.com>, linux-ext4@vger.kernel.org, oe-lkp@lists.linux.dev, ceph-devel@vger.kernel.org, linux-nfs@vger.kernel.org, Rohith Surabattula <rohiths.msft@gmail.com>, linux-erofs@lists.ozlabs.org, v9fs@lists.linux.dev, samba-technical@lists.samba.org, Steve French <sfrench@samba.org>, linux-fsdevel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, Linus Torvalds <torvalds@linux-foundation.org>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On Mon, Jul 17, 2023 at 3:35=E2=80=AFAM kernel test robot <oliver.sang@inte=
l.com> wrote:
>
>
>
> Hello,
>
> kernel test robot noticed "canonical_address#:#[##]" on:
>
> commit: 830503440449014dcf0e4b0b6d905a1b0b2c92ad ("[PATCH v7 2/2] mm, net=
fs, fscache: Stop read optimisation when folio removed from pagecache")
> url: https://github.com/intel-lab-lkp/linux/commits/David-Howells/mm-Merg=
e-folio_has_private-filemap_release_folio-call-pairs/20230628-185100
> base: https://git.kernel.org/cgit/linux/kernel/git/akpm/mm.git mm-everyth=
ing
> patch link: https://lore.kernel.org/all/20230628104852.3391651-3-dhowells=
@redhat.com/
> patch subject: [PATCH v7 2/2] mm, netfs, fscache: Stop read optimisation =
when folio removed from pagecache
>
> in testcase: vm-scalability
> version: vm-scalability-x86_64-1.0-0_20220518
> with following parameters:
>
>         runtime: 300
>         thp_enabled: always
>         thp_defrag: always
>         nr_task: 32
>         nr_ssd: 1
>         priority: 1
>         test: swap-w-rand
>         cpufreq_governor: performance
>
> test-description: The motivation behind this suite is to exercise functio=
ns and regions of the mm/ of the Linux kernel which are of interest to us.
> test-url: https://git.kernel.org/cgit/linux/kernel/git/wfg/vm-scalability=
.git/
>
>
> compiler: gcc-12
> test machine: 128 threads 2 sockets Intel(R) Xeon(R) Platinum 8358 CPU @ =
2.60GHz (Ice Lake) with 128G memory
>
> (please refer to attached dmesg/kmsg for entire log/backtrace)
>
>
>
> If you fix the issue in a separate patch/commit (i.e. not just a new vers=
ion of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <oliver.sang@intel.com>
> | Closes: https://lore.kernel.org/oe-lkp/202307171548.7ab20146-oliver.san=
g@intel.com
>

This has already been fixed with
https://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm.git/commit/?h=3Dmm-=
everything&id=3Daf18573471db5c5c9b96ec95208c340ae7c00e64


>
> [   45.898720][ T1453]
> [   45.907480][ T1453] 2023-07-16 00:36:07  ./case-swap-w-rand
> [   45.907481][ T1453]
> [   45.917873][ T1453] 2023-07-16 00:36:07  ./usemem --runtime 300 -n 32 =
--random 8048142432
> [   45.917876][ T1453]
> [   47.348632][  T973] general protection fault, probably for non-canonic=
al address 0xf8ff1100207778e6: 0000 [#1] SMP NOPTI
> [   47.359787][  T973] CPU: 123 PID: 973 Comm: kswapd1 Tainted: G S      =
           6.4.0-rc4-00533-g830503440449 #3
> [   47.370301][  T973] Hardware name: Intel Corporation M50CYP2SB1U/M50CY=
P2SB1U, BIOS SE5C620.86B.01.01.0003.2104260124 04/26/2021
> [ 47.382201][ T973] RIP: 0010:filemap_release_folio (kbuild/src/x86_64/mm=
/filemap.c:4063 (discriminator 1))
> [ 47.388172][ T973] Code: 00 48 8b 07 48 8b 57 18 83 e0 01 74 4f 48 f7 07=
 00 60 00 00 74 22 48 8b 07 f6 c4 80 75 32 48 85 d2 74 34 48 8b 82 90 00 00=
 00 <48> 8b 40 48 48 85 c0 74 24 ff e0 cc 66 90 48 85 d2 74 15 48 8b 8a
> All code
> =3D=3D=3D=3D=3D=3D=3D=3D
>    0:   00 48 8b                add    %cl,-0x75(%rax)
>    3:   07                      (bad)
>    4:   48 8b 57 18             mov    0x18(%rdi),%rdx
>    8:   83 e0 01                and    $0x1,%eax
>    b:   74 4f                   je     0x5c
>    d:   48 f7 07 00 60 00 00    testq  $0x6000,(%rdi)
>   14:   74 22                   je     0x38
>   16:   48 8b 07                mov    (%rdi),%rax
>   19:   f6 c4 80                test   $0x80,%ah
>   1c:   75 32                   jne    0x50
>   1e:   48 85 d2                test   %rdx,%rdx
>   21:   74 34                   je     0x57
>   23:   48 8b 82 90 00 00 00    mov    0x90(%rdx),%rax
>   2a:*  48 8b 40 48             mov    0x48(%rax),%rax          <-- trapp=
ing instruction
>   2e:   48 85 c0                test   %rax,%rax
>   31:   74 24                   je     0x57
>   33:   ff e0                   jmpq   *%rax
>   35:   cc                      int3
>   36:   66 90                   xchg   %ax,%ax
>   38:   48 85 d2                test   %rdx,%rdx
>   3b:   74 15                   je     0x52
>   3d:   48                      rex.W
>   3e:   8b                      .byte 0x8b
>   3f:   8a                      .byte 0x8a
>
> Code starting with the faulting instruction
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>    0:   48 8b 40 48             mov    0x48(%rax),%rax
>    4:   48 85 c0                test   %rax,%rax
>    7:   74 24                   je     0x2d
>    9:   ff e0                   jmpq   *%rax
>    b:   cc                      int3
>    c:   66 90                   xchg   %ax,%ax
>    e:   48 85 d2                test   %rdx,%rdx
>   11:   74 15                   je     0x28
>   13:   48                      rex.W
>   14:   8b                      .byte 0x8b
>   15:   8a                      .byte 0x8a
> [   47.408103][  T973] RSP: 0018:ffa00000094f7b28 EFLAGS: 00010246
> [   47.414266][  T973] RAX: f8ff11002077789e RBX: ffa00000094f7c08 RCX: 9=
8ff110020777898
> [   47.422337][  T973] RDX: ff11002077788f71 RSI: 0000000000000cc0 RDI: f=
fd4000042870d00
> [   47.430417][  T973] RBP: ffa00000094f7b98 R08: ff110001ba106300 R09: 0=
000000000000028
> [   47.438497][  T973] R10: ff110010846bd080 R11: ff1100207ffd4000 R12: f=
fd4000042870d00
> [   47.446575][  T973] R13: ffa00000094f7e10 R14: ffa00000094f7c1c R15: f=
fd4000042870d08
> [   47.454658][  T973] FS:  0000000000000000(0000) GS:ff110020046c0000(00=
00) knlGS:0000000000000000
> [   47.463703][  T973] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [   47.470406][  T973] CR2: 00007fddcaf308f8 CR3: 00000001e1a82003 CR4: 0=
000000000771ee0
> [   47.478496][  T973] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0=
000000000000000
> [   47.486594][  T973] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0=
000000000000400
> [   47.494696][  T973] PKRU: 55555554
> [   47.498372][  T973] Call Trace:
> [   47.501795][  T973]  <TASK>
> [ 47.504870][ T973] ? die_addr (kbuild/src/x86_64/arch/x86/kernel/dumpsta=
ck.c:421 kbuild/src/x86_64/arch/x86/kernel/dumpstack.c:460)
> [ 47.509153][ T973] ? exc_general_protection (kbuild/src/x86_64/arch/x86/=
kernel/traps.c:783 kbuild/src/x86_64/arch/x86/kernel/traps.c:728)
> [ 47.514826][ T973] ? asm_exc_general_protection (kbuild/src/x86_64/arch/=
x86/include/asm/idtentry.h:564)
> [ 47.520679][ T973] ? filemap_release_folio (kbuild/src/x86_64/mm/filemap=
.c:4063 (discriminator 1))
>
>
> To reproduce:
>
>         git clone https://github.com/intel/lkp-tests.git
>         cd lkp-tests
>         sudo bin/lkp install job.yaml           # job file is attached in=
 this email
>         bin/lkp split-job --compatible job.yaml # generate the yaml file =
for lkp run
>         sudo bin/lkp run generated-yaml-file
>
>         # if come across any failure that blocks the test,
>         # please remove ~/.lkp and /lkp dir to run from a clean state.
>
>
>
> --
> 0-DAY CI Kernel Test Service
> https://github.com/intel/lkp-tests/wiki
>
>

