Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FFAE2BB1A1
	for <lists+linux-erofs@lfdr.de>; Fri, 20 Nov 2020 18:44:45 +0100 (CET)
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Cd3pL0Zj2zDqyf
	for <lists+linux-erofs@lfdr.de>; Sat, 21 Nov 2020 04:44:42 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.ozlabs.org;
	s=201707; t=1605894282;
	bh=/eSjWRDgNfqjcxSzuMArpXGdWwk1PdW9TL111ox7JTo=;
	h=To:Subject:Date:References:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From:Reply-To:Cc:From;
	b=UvRddi3uwF4NV2yB0stEZB9bavq27YmkP1X18W4TE3uVlX5txPXDy4UxZpLR8CGre
	 OYa40FTenUB1W50gOa5ylswR4eoCz7mbh9jEgPsEzj4y5ug3kxFJL2EZVSX6035u3t
	 XiE/rRwiENJpwuMoF4eweAf8g4AyNg9QV84yHdCbjD37Y2dePnDGgs+3U85AKyOOTF
	 wNPdP3OyVtkWPfuT+q9YFG9u5LWIYvltZOED8s/mumOTY4WfPZpbg3bIITAV26Dtuj
	 ZpgGHyBoNyFMIBoah7Uv6f/3fIOzLH/wSIT3+lmVYNeFW8q2XatasJs7Vi+KUN+Oo2
	 RVdaOFGzHN3tg==
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
 spf=pass (sender SPF authorized) smtp.mailfrom=aol.com
 (client-ip=98.137.64.31; helo=sonic307-55.consmr.mail.gq1.yahoo.com;
 envelope-from=hsiangkao@aol.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=reject dis=none) header.from=aol.com
Received: from sonic307-55.consmr.mail.gq1.yahoo.com
 (sonic307-55.consmr.mail.gq1.yahoo.com [98.137.64.31])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4Cd3lX0FgpzDq8g
 for <linux-erofs@lists.ozlabs.org>; Sat, 21 Nov 2020 04:42:13 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aol.com; s=a2048;
 t=1605894128; bh=KpSb42/zR1OaXHfNxOFxsd2C2hrWUjhoUiGPYV092RM=;
 h=From:To:Cc:Subject:Date:References:From:Subject;
 b=ZaWUWLz0vrMcApW6YOFlQJo/YXN6UNYVn/k8bFaXlW4gloQZ3DrXQgQoFiRiZHQyWCGLmsfHlEyXqtHba/yo4+ikctdLlYu5q97K2x484jILlqllNO8FvvqLx2Dxsa2KthBuqFUisKwGONHD7pg/fjBWNorsUFnPubI302hAtdcP52/f8IRx3jSQMM7zzu2/hE8yOb2LR4KmVWmDnQuhiMqufpp1AU+lC3yYVILv5bLSrPq8m7uNtu5plB2JuPsNQIPPH8VrDh7usMZV5KB75/lbgaGlwyELQ5qhMAQbukUYBnkBc49loftCp3r6V/hvmWdmJJtOcBcRKOt+F/AB2Q==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048;
 t=1605894128; bh=eoJJUKrzEzM5VIK3tQDAEUjlC0hFgtyoAw1+xWNxY5F=;
 h=From:To:Subject:Date:From:Subject;
 b=uluO7VhiyNGUllXAt5nWKAgTnSTq2ULsKXggUzoswAAYcxaTsQeuFrdCMlhgW1XI2/1SUegl9bmd+qQNJt/u46HU9+LENn2O9ISWDbgCk+i0jpLy/2wgPQtDh3qwSosE6aYyh7PzWxAmqFzyZz/vvVQOq8ShUOs/HrwaQrDtbWGM3oIw3qymyt4OA/xad4OdmqpZ4CdSZ2b1TPyzvzzLpsUnJVMYz1suohikDKhfCn2mO3rFWkip2EAo2YM92ogHfnujAHNwEGucrLlday93RVbHdlvdw1vWF90U7+W2RePPG7ySb5CKO+8gku6hy52P3z+UKzpnZ9TqSfgIJQLWDQ==
X-YMail-OSG: Ovrc1e8VM1ldMrtBJ.CDtMr1C.5Iiv_._iyjY.PmIc2oXBU7P1fvEp8sqeyGnJe
 uSbHQHyqtkllSmiNchPb8REzsxUn1trsAy7XUlfS7QT0ehQ78.C9D2BA1apBBlwAUZwK4LthxnYb
 2sYNG4eD2Jn.k9LJsG.GKWJv6Mnp8rREFWompDPHUB7BmIXdnVDZTb5rTmEBmv.6ey3US0UzX1NQ
 frCTMtf8mv.QYgvh.nCYQKoCBzMzlYNYYfqWMw3pr_cBKuHWjBcwQWfjeiXZ9vtl3Orwo3_SCFh3
 jwI_QlNis5z93m5yFygzY8X1.vQJTfQO3wiHQ02a89xALC6pw4wlLSykX_JDWzWUWjQ0RDR9KRV.
 74Y9VlNq.TGog.jWF0zpb6Xt6Kf6ET5B.0G_1HHR2imP5w1xxlSFNY.O5TA5usVxmtmJl0ilrpoo
 W7qL4eTSek6vjj2XxpQhWhIshr_geNRpVTVbbFuEnJ7zaVdEV7Ijp6Fzhpa.Nkzr43SoWJ3bsksJ
 RarCstdUIfhBMGnRMeQoeY3Plr.qQECuQ9UR0v.A6kNjTGDdCdSsNST8Siv9mAWZjgUCOLr88Wa.
 3mlV2GXmsYFNRrIdtfD2PwU_XRvhjo1_XNpvgMF3XPOTQZQXVx9veBfjagiMmu8jf644rrza7TVs
 Dt6xxzVIIKLjBy9wSi2aUP473Xl0ChdshoADpxm6UVKa4fbiZHa40_YnhS6oF3UlZH9sZMlHD8Fm
 mmyDC9SVePKYSV7WcGEbjSevUkofA4XfeNlvjPPitQHl.P3UsFPKNdLx.G2lRBkFHAhykPXIiRoX
 yFzjH2.kjX86Z22dcBwXcMmL2PPspJqshp86UmtOZE85jE4XIUWrrIxZRPDf3HbNYMns2iVVyqDr
 gCNZA5lAlZfxwE9Q34KUKfo2bQglElTu6ah9q2.D9YKpkrTkq78xDlyBNk_Q5oTIaEqdnPxUKfuK
 wHyWMd9XO2sz.CVdiqkhUNC2LVF.jJCY4F8eNykdYIMV82yV3pW8xG7Gvn6dXCiUAxTKjzQS7WXf
 tzDaRHDCm6fFp0TPNNC14uoJXz_Lf5JWlGEFUMKhwlbCDcxdSK_TGjBgIL_tG.7m7X0ky5YtKymF
 IjqkGvBngfCIWGHZ047ZahGCqAZNrfEGKWv_JLrW9gQQ5lxDNEe7t.j1ZVYDen.fePAEOjfTEVyL
 65emfJhOQzjve8AEkuUg7iN.vfqKDM5zfCa3G.kvWa6TCaqNb4GaBId1qfUtJk_SfoLY1npIFdFF
 yVHaxclHDxb4VFaksec5mXgyPhwhgm2wjrXI4RVQbKpayGkBh_KS9OHb3Kgc9AnfWTJhx6T33VcE
 ScLLPObrY50V_jPPUD8ck77wY6nFTsRcV4XgzEIvWd4_0EqY7I5pV8_FnGmfDOsYYWxYGse6j5ST
 UZalJjmgq5xj2I1N1yL5YLVZQ9uYBNxpPI3ufEjteBV2ZXkACLP.QvokSdE23_cOi4oTSd7iMkJa
 Bgn1NGdJSZueeVyvyTsYZVMp5YzSqRqeKna_67HBL0y762GmLuXqm_7Qna_0V6BFG8WuiLRqLwid
 mB1hmNN_1FFriuauET3FMkbrnkkWKhMxOjYDSSy8rbBTi1UeDAnZNCdRP0Ao.8J_Gx2bxwz6Jbr8
 MNe8rQJutmm6m5CQ3KyEotODjbILE6Oi53J0MWuGbGxBxRhzsoTm0VrTXo.Uv_XXR2KfyQGW7NAm
 AlONsiJkz2Zn4om2PODpSknnl71U2DsVZlnsjAPllfiuV56yXEDcM6PdjRkoezDZtE_MaxiMS_mV
 tcLvxxLlwMtQpiXyRxj.jUEp1EkkMJroYoW3EHxzl0xU0OgzgTn2zd9oNPc.Lic5q5TFHv7KWuC5
 aRO2U3Ncg5gWjy9r72Hj6cj.H8qFWNHM0Iwyb_1DeIDs0RCcgkEkeXGrMCzm8q0Lf4gMxay9PPVk
 RLcX3Gin4guPC8_LRdYqs07BQvGsdgnXT6HA_4hHuZBF.32zCgTkPA4BJeOZVJ6poGgw3XG7sTUc
 af2qUrfRK.VvB04UhdDiKtqXS0s7Hisy8Zey_KHstX52jk22ccRKKZ27qy94cijWoRYgDo.oV2_8
 RYbRd5ljvsEPjmEY0_jXg61gEgO481toHnlN4j1wKYL0xry8NaCe_8ZsgBekgVKjVSPaunXEqzme
 XB0QtwM6iuqKRV1Tmu71Y5r08dn9Dvu_coWZBrwOyXpknLIHV0niAw03t8Jy0WbQu4lAub8xPPp9
 8ztxpWDn6OS7c4VXygHNZ.D4dancltcU4ekLonPMxERM.ad3DlD5X7X9SnwzWHKt.4gwJB1gbtXs
 6nTAf3MIUF6jHPr1WWmGfbXis1AX4DmvpjbXmRi8ikRtE_FPf2jDEmPei2I5HjYTsfRQ6d2N6.jt
 .rURwTejTE0PyC71zpDg5ijssheHa2TL5ysMxUZfrxD6m4XUn4uBJcRMC3lUg8EGX.W4lhMO6g47
 iMUjT33vNPlQ4PbHhm3CmwrDom0xPsVqiQTygKbgBWYDISjq.iSzco_6UK67uPmNZGio7pNqSntX
 JCFOuclnwyuF2kc..8H5haT.ly112az3S8XxVepYMlK6KYTOBS8x0EKYSPYyPGYSs2e.e8leMDLI
 RqrJwINrgCnPaJbb2qWEF2Z2DRFAFPPVxcFFJeps1pCyA4NIO4RzrRa0jUiF6xiQ28Rfm6i5VgVz
 CmfjddBiGJFm4fPDOWHTrDu48JiEEr0ZmAwduLqM8NDOnI98mN_r_0rMnZgy9FGvbvKi.fDOusBe
 g0Xxa9EnXrILlI3iHSpA4cpP1IA4k0pDafzTTAjq3WgVyfsXkP8h6vsd..qPfCE0mDGWKiLevhZQ
 vYWwobODQInXug.yZgAPEIkXPx3Oz8i136w--
Received: from sonic.gate.mail.ne1.yahoo.com by
 sonic307.consmr.mail.gq1.yahoo.com with HTTP; Fri, 20 Nov 2020 17:42:08 +0000
Received: by smtp423.mail.ir2.yahoo.com (VZM Hermes SMTP Server) with ESMTPA
 ID 2f08c2150b87ae58ff1849141a8a4a3f; 
 Fri, 20 Nov 2020 17:42:05 +0000 (UTC)
To: linux-erofs@lists.ozlabs.org
Subject: [PATCH 0/3] erofs-utils: introduce fuse implementation
Date: Sat, 21 Nov 2020 01:41:43 +0800
Message-Id: <20201120174146.18662-1-hsiangkao@aol.com>
X-Mailer: git-send-email 2.24.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
References: <20201120174146.18662-1-hsiangkao.ref@aol.com>
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
From: Gao Xiang via Linux-erofs <linux-erofs@lists.ozlabs.org>
Reply-To: Gao Xiang <hsiangkao@aol.com>
Cc: Guo Weichao <guoweichao@oppo.com>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

From: Gao Xiang <hsiangkao@aol.com>

Hi all,

I've finished cleanup erofsfuse - a fuse implementation of erofs
just now. It's now considered as multithread safe since it's
currently stateless by killing useless caches and using high-level
libfuse APIs(also libfuse itself is MT-safe). Therefore, I don't
need to release liberofs MT-safe version for now as well.

As I said eariler, the main use of erofsfuse is to support handling
erofs images on older kernels without kernel modification, which
was requested by real vendors (thanks to folks from OPPO to pick
it up).

And to summarize the benefits of erofsfuse, I think it would be:

 - erofs images can be supported on various platforms;
 - an independent unpack tool can be developed based on this;
 - new on-disk feature can be iterated, verified effectively.

erofsfuse will be included in the upcoming erofs-utils v1.2, but
disabled by default for now. Since it still needs sometime to
stablize and also notice LZ4_decompress_safe_partial() was broken
in lz4-1.9.2, which just fixed in lz4-1.9.3 days ago [1].

BTW, recently some other people get in touch with me in private
to ask for some latest micro-benchmark among compression fses,
so I spared some extra time on this as well, see:
https://github.com/erofs/erofs-openbenchmark/wiki/linux_5.10_rc4-compression-FSes-benchmark
I might test on hikey960 board as well yet need to seek more
extra time but I think no much difference on relative
relationship (but yeah, CPU-storage combination is vital for
seqread uplimit).

Thanks,
Gao Xiang

Cc: Li Guifu <blucerlee@gmail.com>
Cc: Huang Jianan <huangjianan@oppo.com>
Cc: Guo Weichao <guoweichao@oppo.com>

Huang Jianan (2):
  erofs-utils: fuse: support symlink & special inode
  erofs-utils: fuse: add compressed file support

Li Guifu (1):
  erofs-utils: introduce fuse implementation

 Makefile.am                |   4 +
 configure.ac               |  22 +-
 fuse/Makefile.am           |  10 +
 fuse/dir.c                 | 103 +++++++++
 fuse/main.c                | 240 +++++++++++++++++++++
 include/erofs/decompress.h |  35 ++++
 include/erofs/defs.h       |   5 +
 include/erofs/internal.h   |  94 ++++++++-
 include/erofs/io.h         |   1 +
 include/erofs/trace.h      |  14 ++
 include/erofs_fs.h         |   4 +
 lib/Makefile.am            |   4 +-
 lib/data.c                 | 206 ++++++++++++++++++
 lib/decompress.c           |  87 ++++++++
 lib/io.c                   |  16 ++
 lib/namei.c                | 264 +++++++++++++++++++++++
 lib/super.c                |  79 +++++++
 lib/zmap.c                 | 415 +++++++++++++++++++++++++++++++++++++
 18 files changed, 1599 insertions(+), 4 deletions(-)
 create mode 100644 fuse/Makefile.am
 create mode 100644 fuse/dir.c
 create mode 100644 fuse/main.c
 create mode 100644 include/erofs/decompress.h
 create mode 100644 include/erofs/trace.h
 create mode 100644 lib/data.c
 create mode 100644 lib/decompress.c
 create mode 100644 lib/namei.c
 create mode 100644 lib/super.c
 create mode 100644 lib/zmap.c

-- 
2.24.0

