Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id CA9D434DD14
	for <lists+linux-erofs@lfdr.de>; Tue, 30 Mar 2021 02:39:36 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4F8VvV5lzfz303h
	for <lists+linux-erofs@lfdr.de>; Tue, 30 Mar 2021 11:39:34 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lists.ozlabs.org;
	s=201707; t=1617064774;
	bh=rnuMXp7gWhy3m6LFyDe5/J05lHFJEpT3BKdBWFdJmN0=;
	h=To:Subject:Date:References:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From:Reply-To:Cc:From;
	b=aetFRJvdcMzimj0H5qqDpT800Z3Todkzx/0d5FfuL/MhCt0MIL+XyR72ZejNaA3Ee
	 bLa3EFi3olnRC3PP6HN+0sGZtfjnKeJxxWV4OwrxxZIqbZ7gsdPxte1xgz12dQiNS0
	 IPkMI5/ZC+qfhrT+Htrcv1QXbjPy0TnQI9sLgbW3v+vgQbYK77J5+aPz3pYVQCM1Ep
	 2p4aNWSR31wx67C1YmfaJ2ssjzFQEzv0oJOTytoj21WlKRLwJRi13BpscqBBeRWfGa
	 zTBW6fmhCVNe3a4qDInoRG+mFhSpvQSAmPgLYJJ5ktPdDDV/4OzG49iHyxfjozPRpO
	 9QnBxoiKYlafg==
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
 spf=pass (sender SPF authorized) smtp.mailfrom=aol.com
 (client-ip=98.137.68.84; helo=sonic306-21.consmr.mail.gq1.yahoo.com;
 envelope-from=hsiangkao@aol.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=aol.com header.i=@aol.com header.a=rsa-sha256
 header.s=a2048 header.b=NABtruPU; dkim-atps=neutral
Received: from sonic306-21.consmr.mail.gq1.yahoo.com
 (sonic306-21.consmr.mail.gq1.yahoo.com [98.137.68.84])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4F8VvQ4rnCz2yRK
 for <linux-erofs@lists.ozlabs.org>; Tue, 30 Mar 2021 11:39:28 +1100 (AEDT)
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048;
 t=1617064763; bh=9pG+4kc3+bYqcscPnU3I1q8meWEacLJgPfgb1H+KzdL=;
 h=X-Sonic-MF:From:To:Subject:Date:From:Subject;
 b=COGGBEzHZPFXt39PLBplEwkggnZxt3io4pnP1pd6EiPr4QrM6Yo44UZwB0rToBZrEhlTnmSq4Yac3tQoje2Sp3UmI9m1DCh+B7ZmIUIgJlPUbrW7QMj4ulFsNW2jVNTyjor89VuwaNsjrYMJBJJQzut1mkVvLKGjn2FZma3MSND6vn1I9Ood+BRcVDE5hV6z4RaWHkHX7oVnXc5KvbMzaD4o4BWlHahrDkMc81RlJJyFDF2E7PjP27/H9QvDbUuz3entJLVq41OBbiXD324Miiah9djsJb2Im+T7mtvJPw6tJj+Dl0hs+06Q0+g+DXR0Qris7Uo/dbSiDdWBJZItzQ==
X-YMail-OSG: uKgmLqcVM1kv2KpCvoanwzwmtGqhbHT8nZsVx0VoHK5GRiLhkHtX_8KSMVIFcHn
 X6pnfCMpqIwdQY50A_DkwCrTOBEksilTUlWWVOtLUxX1AgVDYo6Kmo0q2u20M_5h9dyPDME8F0BW
 j00cu15RjO3nSN2THMlshrxyt.hz5mz1ZLOQj9TubtIKFQq0RoPxVP86NXxzNu4gN22pGAzjdcXy
 KLB1VpWBClC.i.rVJw0olroj07xrJc8dS73yfnjqL4kdQWLZ13mzIsB.wPfS0sg2M2xI33lpJRbr
 KFfvomoOnMmugeOYA1PaNxpsZTdIGU8Ftrn0b66Y1ZOLinGCdjxEgg0v_qNZqUOInWSvfKU.fA1D
 d.nCBGc7WICdD.3wLHqavXABUD50yts7wtbJEhhS.nHOce20fE8sGcJPI9rS2b9XtEOnCNmoB2l0
 NUs8uZjBcSW2HPb3h81aK0yS.pqPZiPT8CdKjswLOQRs81NOms9ujgu5S2mwrLhwizSahvXC2_B9
 gnsuVPZNtqybwl8vx8g1u1PenOdGD3X5Nz7xSrTSePexlIcIft_ODQRusHZkkhwDSOb9kVnijB.S
 DYWZhmpU6Wukh91KCORnsP0zSXu8u_EKyXY201Y8EM_I_dl1xNppXl8UR_Dy6kQSv7LH_CYSiiCc
 wqf2FMpfP0vkga1C8VpN3GMWDmCJN8zIiDZl9o3gQsNSSo3mdYsNfcItjGMFfJqfggILnHVv56lZ
 4IAjmNjVOl0DIybuk3HfN4QTnAyIHJLjZG59OQO0ZuqJLcQXEIKSjakl1miBtTjV5jEAHWpSq1j1
 8YQtuzOmDR8uIJ0uiPWmi.DfjA8Aq7cvZcdUMGrh0fuYrtPMwC8sZWfNK3fIWz8judkhZhEc5e1m
 FMl_msvTWJ7YUy.Ze4ufsf73.gJTeI7HxUxSAiwK3VeJ_z4whbnHIJWiCuBkmsbhHQNq7vcUyqPs
 KvEVZ497Fn.Z9CBw6t79e5nnqfCSQDUDfm9qPOnUgBsqJuBJu_381H5HLDg78gez65sZvQmWOTy1
 6NiWvNKL1F765UwYIUbchZDx.Df5NluQABv2oABM4XQg1Sir2W2YV65049fMVHbPmowZCnmdlsV2
 s3g9JAzOcGXm9FrjOr.NGk51wxiKPOnXaNpFLAVuTbxw7xILN6m.omFv7l2.j.rvAKdjaLwb9R2i
 .06gZSGoEAHh0zONEOonJkjZeNN4uD68JmHAWEGuArVG2XQJTLugZMTzRL204qlxSdvsqszo0cVV
 QN0dcrmseq4wM.V4Ed8oub8TRPHiFllhBEgmsv.N5TDQ1WC.mrTIUlAsDjPrxWKRNGxITOaCz2DJ
 QHKE1HQXSQoXKSqpU_6AZuJHsSL4g0b4L8O6Dwb1MAA6seo1o9pgGLS.I5LCsL_yzRh.RtGGGBXh
 wVoywMftNFSMpwAnuiMGQ57jVSZkWbMPwNiC5zOaUXrm2iFCjACjeMia361HObvLLF6cEQYhULpe
 UKkS.68m__y8d7jC4U3l3VQH4PLaiTbObKxUnUKnjD8ZhXVBIbUrsE0oU0WBqWcbt2Rh3dZ4.Tyz
 GtSm1EMhg6LkulwzO4P04wiqzj1l2qngeHAEdM8HZ97rABov5hXr2CQe8MCKgDPGKOXmGEP6X9ez
 PwCm4nKdCrlgwLfWWFajnQSS4rwG2iiLc9pVR9jw8hnMOv9TIcuuOoFnCZ0NqheFC0wzrBK687df
 nd0kD8PtInfwoi81hmG99V3d3BtMrHo_GejxM2_Xx4_gr0eZqZqz7pvMw2IYgQ34eLMnFKvP0c0c
 M0Y9hoZ5ny162z.xT477hv2NJISh7sJg_9lfEhKT9GxPYsE_0Zfdp3jbH567aZqhK2aCJUlGq3nY
 WjchBxXkzhrEGR4jl_U.jBTWqv0Jt211vvyhMOtzQxsc42CiTnWStduroPHa.frvvoZTMM2Ex4If
 fQZwaHE.HqDUxQITpW_HHhApE9PJoj2tYfS21C8DJ0.97LlCljZRhw73IBwtnuBolzeoLP6vv_aq
 h4HMkxyBv1aOUECz8xuVa1wouD.X.hPVTWKiL6QZ1jeqFKO79TAe0Y5nliwutBwOBpxI2H65YtiS
 YZG6VaopxIo0fdSEwXR4Rkg7QXUUA5C_PAVvePdaGX0Wj2CBv1AIdDbAfFCk8ERMhwDIfmBT80lu
 spNDHV2qJhUXBrpF2RIe3NUarRQVjPpQE7ZlN5xYj5n288Tt0b3m6xqahhomg1CO1iNH_2bLzR2r
 VdgiC4ncmtRlHJC_8krai02lVpf0iy7AdNwOzWKEjojXltFgyiaG_mxLQX0AbyPdG1u6NksQ7VQL
 tl2iRFH.VxvYNv7NiK_wG3opLRuk3LSlYwQRmE.YJEhxOt5tkGhDhgAk4KMAXkgkKHs8KNgq4pt9
 ZeLdRKPQcpCCcMqYJVqVmMGL5LFfp86fldG.mO0d9vhBA_lyNnO5l2sNFqkZCMDRcWgkMIUQQi.H
 SaeJgn27wpVK0A5GGW5BRCM6rqoOSRF6zNvQom1j5YhyvjFXVryNsQ5aczICnsElsqodj.hF207d
 MYh0X6iNvYeMdTUM6oP8u4H5G9Dr5xl7kTRGf4Cb5Xqf5IDECYB79Fo4DoNVWjL1dwitopmKEnBZ
 wISVdvmF26eOuaRM2fNivLgYuwCusff6cSAogw7kNcI271PehMTYOi9D3jAYbfvUVMY.q3WDnabw
 RYQrkQYTgK5szOng7KIivOJmWHDIIYONg8GtfrBRTep3J2yKGuDOMz.Y2LJ7CVRaak6malgNgFsZ
 ocux23IF6YUSVyuPwWPvFLID1K0AufHeWMOeAlw.QKGOjNP3v52x55YQ0p98K_rdPlB2O2ppu9Ns
 Bod5YTuizSUZ6pywRT7pbBlA0.g0Fe6XkaKYSihYt6.TgK8KVKfa.SrvOK9wcUwSTJ.EVb13K2k7
 9.zTVI8iaiK3b0zM6cdl7pspsGTRM7ZckTnIdnhWmogdoCk47u4EYhE1Eht_4Cmduvd_lVNq.LfE
 3EN3EJHQ4MG1GMyHjJgqDxyvhTvzIhYTfz9FlpLVgLG8VmKUNxXzdQZvXi7zdRIltpUIo6hdaBNk
 WCyHsdCJNdhzxZebQJtQhLQl62_leDfOzeDDk4XZTSxzZh2bs.8U1dvhFw36k22nIeEpyq_VkRqM
 m1XNQxjDwXkjt7zMsmWMzNj2RT2RB1mLFHMuEMvo9UxWjHEYmc9Zq2Ii7oeoAQqqch5Jvxg--
X-Sonic-MF: <hsiangkao@aol.com>
Received: from sonic.gate.mail.ne1.yahoo.com by
 sonic306.consmr.mail.gq1.yahoo.com with HTTP; Tue, 30 Mar 2021 00:39:23 +0000
Received: by kubenode579.mail-prod1.omega.gq1.yahoo.com (VZM Hermes SMTP
 Server) with ESMTPA ID 27cc0a93ae52fff3a17931d8aba7bccb; 
 Tue, 30 Mar 2021 00:39:18 +0000 (UTC)
To: linux-erofs@lists.ozlabs.org, Chao Yu <yuchao0@huawei.com>,
 Chao Yu <chao@kernel.org>
Subject: [PATCH 00/10] erofs: add big pcluster compression support
Date: Tue, 30 Mar 2021 08:38:58 +0800
Message-Id: <20210330003908.22842-1-hsiangkao@aol.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
References: <20210330003908.22842-1-hsiangkao.ref@aol.com>
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
Cc: nl6720 <nl6720@gmail.com>, Lasse Collin <lasse.collin@tukaani.org>,
 LKML <linux-kernel@vger.kernel.org>, Guo Weichao <guoweichao@oppo.com>,
 Miao Xie <miaoxie@huawei.com>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

From: Gao Xiang <hsiangkao@redhat.com>

Hi folks,

This is the formal version of EROFS big pcluster support, which means
EROFS can compress data into more than 1 fs block after this patchset.

{p,l}cluster are EROFS-specific concepts, standing for `logical cluster'
and `physical cluster' correspondingly. Logical cluster is the basic unit
of compress indexes in file logical mapping, e.g. it can build compress
indexes in 2 blocks rather than 1 block (currently only 1 block lcluster
is supported). Physical cluster is a container of physical compressed
blocks which contains compressed data, the size of which is the multiple
of lclustersize.

Different from previous thoughts, which had fixed-sized pclustersize
recorded in the on-disk compress index header, our on-disk design permits
variable-sized pclustersize now. The main reasons are
 - user data varies in compression ratio locally, so fixed-sized
   clustersize approach is space-wasting and causes extra read
   amplificationfor high CR cases;

 - inplace decompression needs zero padding to guarantee its safe margin,
   but we don't want to pad more than 1 fs block for big pcluster;

 - end users can now customize the pcluster size according to data type
   since various pclustersize can exist in a file, for example, using
   different pcluster size for executable code and one-shot data. such
   design should be more flexible than many other public compression fses
   (Btw, each file in EROFS can have maximum 2 algorithms at the same time
   by using HEAD1/2, which will be formally added with LZMA support.)

In brief, EROFS can now compress from variable-sized input to
variable-sized pcluster blocks, as illustrated below:

  |<-_lcluster_->|________________________|<-_lcluster_->|
  |____._________|_________ .. ___________|_______.______|
        .                                        .
         .                                     .
          .__________________________________.
          |______________| .. |______________|
          |<-          pcluster            ->|

The next step would be how to record the compressed block count in
lclusters. In compress indexes, there are 2 concepts called HEAD and
NONHEAD lclusters. The difference is that HEAD lcluster starts a new
pcluster in the lcluster, but NONHEAD not. It's easy to understand
that big pclusters at least have 2 pclusters, thus at least 2 lclusters
as well.

Therefore, let the delta0 (distance to its HEAD lcluster) of first NONHEAD
compress index store the compressed block count with a special flag as a
new called CBLKCNT compress index. It's also easy to know its delta0 is
constantly 1, as illustrated below:
  ________________________________________________________
 |_HEAD_|_CBLKCNT_|_NONHEAD_|_..._|_NONHEAD_|_HEAD | HEAD |
    |<------ a pcluster with CBLKCNT --------->|<-- -->|
                                                   ^ a pcluster with 1

If another HEAD follows a HEAD lcluster, there is no room to record
CBLKCNT, but it's easy to know the size of pcluster will be 1.

More implementation details about this and compact indexes are in the
commit message.

On the runtime performance side, the current EROFS test results are:
 ________________________________________________________________
|  file system  |   size    | seq read | rand read | rand9m read |
|_______________|___________|_ MiB/s __|__ MiB/s __|___ MiB/s ___|
|___erofs_4k____|_556879872_|_ 781.4 __|__ 55.3 ___|___ 25.3  ___|
|___erofs_16k___|_452509696_|_ 864.8 __|_ 123.2 ___|___ 20.8  ___|
|___erofs_32k___|_415223808_|_ 899.8 __|_ 105.8 _*_|___ 16.8 ____|
|___erofs_64k___|_393814016_|_ 906.6 __|__ 66.6 _*_|___ 11.8 ____|
|__squashfs_8k__|_556191744_|_  64.9 __|__ 19.3 ___|____ 9.1 ____|
|__squashfs_16k_|_502661120_|_  98.9 __|__ 38.0 ___|____ 9.8 ____|
|__squashfs_32k_|_458784768_|_ 115.4 __|__ 71.6 _*_|___ 10.0 ____|
|_squashfs_128k_|_398204928_|_ 257.2 __|_ 253.8 _*_|___ 10.9 ____|
|____ext4_4k____|____()_____|_ 786.6 __|__ 28.6 ___|___ 27.8 ____|


* Squashfs grabs more page cache to keep all decompressed data with
  grab_cache_page_nowait() than the normal requested readahead (see
  squashfs_copy_cache and squashfs_readpage_block).
  In principle, EROFS can also cache such all decompressed data
  if necessary, yet it's low priority for now and have little use
  (rand9m is actually a better rand read workload, since the amount
   of I/O is 9m rather than full-sized 1000m).

More details are in
https://lore.kernel.org/r/20210329053654.GA3281654@xiangao.remote.csb

Also it's easy to know EROFS is not a fixed pcluster design, so users
can make several optimized strategy according to data type when mkfs.
And there is still room to optimize runtime performance for big pcluster
even further.

Finally, it passes ro_fsstress and can also successfully boot buildroot
& Android system with android-mainline repo.

current mkfs repo for big pcluster:
https://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs-utils.git -b experimental-bigpcluster-compact

Thanks for your time on reading this!

Thanks,
Gao Xiang

Gao Xiang (10):
  erofs: reserve physical_clusterbits[]
  erofs: introduce multipage per-CPU buffers
  erofs: introduce physical cluster slab pools
  erofs: fix up inplace I/O pointer for big pcluster
  erofs: add big physical cluster definition
  erofs: adjust per-CPU buffers according to max_pclusterblks
  erofs: support parsing big pcluster compress indexes
  erofs: support parsing big pcluster compact indexes
  erofs: support decompress big pcluster for lz4 backend
  erofs: enable big pcluster feature

 fs/erofs/Kconfig        |  14 ---
 fs/erofs/Makefile       |   2 +-
 fs/erofs/decompressor.c | 216 +++++++++++++++++++++++++---------------
 fs/erofs/erofs_fs.h     |  31 ++++--
 fs/erofs/internal.h     |  31 ++----
 fs/erofs/pcpubuf.c      | 130 ++++++++++++++++++++++++
 fs/erofs/super.c        |   1 +
 fs/erofs/utils.c        |  12 ---
 fs/erofs/zdata.c        | 193 ++++++++++++++++++++++-------------
 fs/erofs/zdata.h        |  14 +--
 fs/erofs/zmap.c         | 155 ++++++++++++++++++++++------
 11 files changed, 556 insertions(+), 243 deletions(-)
 create mode 100644 fs/erofs/pcpubuf.c

-- 
2.20.1

