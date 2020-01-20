Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E4475142450
	for <lists+linux-erofs@lfdr.de>; Mon, 20 Jan 2020 08:42:08 +0100 (CET)
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 481Nsp0cX0zDqTd
	for <lists+linux-erofs@lfdr.de>; Mon, 20 Jan 2020 18:42:06 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.ozlabs.org;
	s=201707; t=1579506126;
	bh=GR8Fa2s+LJSI7cDNIeRFHNqs4rtnh3Cs4JXU6t6iqz0=;
	h=Date:To:Subject:References:In-Reply-To:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:Cc:
	 From;
	b=lC205hDu1YOkRf+Wz+b6BPhS3fidcZqvU8yzgKTX5N3J2jVEI7n7DE/zCfqwlo3BB
	 vweMwKYOFAep29/24pP8XTT4FZi492JcAWJUZzm154p2S6XEdtok00BdS3rvKLsf05
	 TIyhvwuDA40AZpm+aSyzLqjT081IkRzlcQ5u4ZTCbNMt4xLYIFRGz0cv/QV//mYAE6
	 U66kOo/L/VAc5yfwO4UFzND6qlQQAbPAPsbokbaCP9itTizTqY/aOkZPIS6MWhe33/
	 3SgdrADh6RMg1Oun+s/wpWB+yVP+wa0A15Y0UmVs2o+VXZCfT5iKulLqhENTYbpusz
	 i6kXF7kWEe4Ew==
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
 spf=pass (sender SPF authorized) smtp.mailfrom=aol.com
 (client-ip=98.137.69.206; helo=sonic312-25.consmr.mail.gq1.yahoo.com;
 envelope-from=hsiangkao@aol.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=reject dis=none) header.from=aol.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=aol.com header.i=@aol.com header.a=rsa-sha256
 header.s=a2048 header.b=n/vzvH76; dkim-atps=neutral
Received: from sonic312-25.consmr.mail.gq1.yahoo.com
 (sonic312-25.consmr.mail.gq1.yahoo.com [98.137.69.206])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 481Nsc6sGgzDqR0
 for <linux-erofs@lists.ozlabs.org>; Mon, 20 Jan 2020 18:41:54 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aol.com; s=a2048;
 t=1579506111; bh=+XGdFgGABpN6auKCzVqr1neDE0YDg3dK3WOG9Fkcsgw=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From:Subject;
 b=n/vzvH76jluZBlEiBIUtR+UnRbL6hj7O6DHzALleCvHeDrIkcp4Do7A5xi9Jv5AKTyCyVCUsIhXaK6u63ZUxFf12UQwuWOYe4qpKx991HyXwTRZxpzUDhdFmtZpBD2VxM1ggPQ0AzJuq0q3feD6PQAbfRaoxZiMbZmo9NGNG7/J+IFEFLXj9Y12lKxyqazqLvsdpT9RtRYLn70KvTC9SMBY7I7cchrdFIMWkIirRpVRvx2gD8enPd74ScEpa8+H/GQDT2c7H+8KzW+GoMOzvanVofGykzDQ2+YX14/hSJQuYzy8Jbeif4lwKzofAnZzPuA2NLiumXWSWPr/n+zHaTQ==
X-YMail-OSG: 1sl9MbYVM1kZZbL_UnHp6lK6xnqqvCmpGzWwgrtwutMveLhcY29_JNBfUGBPDw9
 OzmerMHM4bopJVV97pfn9uDhuaYAiGkmwRYTb3uDm73p.3h5KGKyJEFQkaJjwkoEos9F3aIyNgsD
 jJaFhoaO1cTvSQHemREPkc.1dtGSDFV_qC1yaHzebi9cVMxFzhkaPGRmF7IK4de24jDROHnnF8Ld
 PIXbE8RUlmDYWNa22NueNbS0zW68Q2xQFkkb852aotTA0E1WPtj6c1.I..ST5mSos.UIw2LOTZTv
 P4GLXLA.BKidtSsVKm8h8DEoQecvd9x7j4KIxY0PmhadjQL2D1Dsqp9NEx6W_RmNX.2EdeiJFQSb
 iqto9Ul0K2TFsG8wyOVIveNuedL77ATRqMsBMgPZ5_OKJ676pkR8UDGQ32XOhSjxlCCEQSSOc3kn
 vXBXtIZd5wKf6Lvkz.ZmrogQRDMu74mcil22CWNCBO3WJpigx4TYGvSEZ9QG9kosZ7FOBsRMRDCS
 UNZ6EENrxaIhHYSVDAk8qjyIGoB1zZwNXZuA9H3R3waPwIAyhTRxBVRBGiEItzzzZh.K2Sr2R5m0
 vbVEMV77VfUv9nPw2qPgWV.vDfhoaG7Ikgo7W6W4LUJse5PeuUNebZYKemFb.aOhYciHHNCMbVYy
 OkCgRPVQ9nMCDdF5FYiB77dhJ_5OYNHHQ4uePItPEWmF_jYEjxtiydPGFRZ1PvGQiGBsAeQBcavQ
 tYqXg5wme92dm3kCTRe5IxndLOJJrqPWSI.GX1IE0kebOunaysB3MKc4FX9M7u.75QoXposWBbF9
 x21OIMsVrxQ8RrWMb0k5Oyu0qe_RiHjgXf9GseeYb17ubcwaAq9Bqv62QCDL7a6mPre3ZGfaBnRQ
 ngrFspLUeWgbgP8VBzMryvJEgGwQwhgx2QHq53Iwr3McVZPz9KRHU5X8KXv9oYJxH4FnfNM40njO
 RFz.G5RCS.yxou_myF5I.0ZL4y2rLOg4GNoO99b6jpGhMRaa3nWyfYFOdUoc9UQb9vW6O36Z_wuz
 EggDJCt0qvMYOCWDy8KUKsfDgKjBqEedpRqVdXg9.6tNEGdypm2prFKGinpwVJnYoFC_TZjyu8YA
 2fmAnPRH_tbWDLyXCL0ZQJzzkm0mo7wQ.WgR1j42BuZOX5dYVoQW1WglQfAa7okKFbSVYzYYOzzk
 af.eoXIMh.Jt7XtqaBisiCS2n8RnZ_N9m8W3ho3Wi9qxoHB8S6dP1EedtamihUPrynEW5lnRk0Ha
 u_G5AhBX.hoYjoMPnejKHo6yvn_ay83xPqjI7UU.dh1Y6WQ76B6qpwRAEibecTOzwMg_GgB7ai_H
 GdRSDVgvmaJpyeDCAjIIc_nxYtSe5DjCl_TbVF4FgbImp4_mf0qkZumakmLvvjuVt5tySzNba5_H
 eJ3U-
Received: from sonic.gate.mail.ne1.yahoo.com by
 sonic312.consmr.mail.gq1.yahoo.com with HTTP; Mon, 20 Jan 2020 07:41:51 +0000
Received: by smtp422.mail.ir2.yahoo.com (Oath Hermes SMTP Server) with ESMTPA
 ID 0ea4360d106f7573b5a855ac946e2ad4; 
 Mon, 20 Jan 2020 07:41:49 +0000 (UTC)
Date: Mon, 20 Jan 2020 15:41:37 +0800
To: Saumya Panda <saumya.iisc@gmail.com>
Subject: Re: Problem in EROFS: Not able to read the files after mount
Message-ID: <20200120073859.GA32421@hsiangkao-HP-ZHAN-66-Pro-G1>
References: <CAHmfoRm7xUwuXfTZ2kr-x9fs59x7b707t183ggbLEtEyO_wznA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHmfoRm7xUwuXfTZ2kr-x9fs59x7b707t183ggbLEtEyO_wznA@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Mailer: WebService/1.1.14873 hermes Apache-HttpAsyncClient/4.1.4
 (Java/1.8.0_181)
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
Cc: linux-erofs@lists.ozlabs.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Hi Saumya,

On Mon, Jan 20, 2020 at 12:25:15PM +0530, Saumya Panda wrote:
> Hi Experts,
>    I am testing EROFS in openSuse(Kernel: 5.4.7-1-default). I used the
> enwik8 and enwik9 as source file (
> https://cs.fit.edu/~mmahoney/compression/textdata.html) for compression.
> But after I mount the erofs image, I am not able to read it (it is saying
> operation not permitted). Simple "ls" command is not working. But if I
> create EROFS image without compression flag, then after mount I am able to
> read the files. Seems there is some problem during compression.
> 
> I will appreciate if someone can help me out why this is happening.

Could you please check if your opensuse kernel has been enabled
the following configuration?

CONFIG_EROFS_FS_ZIP=y
CONFIG_EROFS_FS_CLUSTER_PAGE_LIMIT=1

By default, they should be enabled, but it seems not according to
the following information you mentioned.

Thanks,
Gao Xiang

> 
> Steps followed:
> *Erofs image creation & mount: *
> mkfs.erofs -zlz4hc enwik8.erofs.img enwik8/
> mkfs.erofs 1.0
>         c_version:           [     1.0]
>         c_dbg_lvl:           [       0]
>         c_dry_run:           [       0]
> mount enwik8.erofs.img /mnt/enwik8/ -t erofs -o loop
> 
> ls -l /mnt/enwik8/
> ls: cannot access '/mnt/enwik8/enwik8': Operation not supported
> total 0
> -????????? ? ? ? ?            ? enwik8
> 
> The problem seen for both lz4 & lz4hc.
> 
> *Erofs image creation & mount without compression: *
> mkfs.erofs  enwik8_nocomp.erofs.img enwik8/
> mkfs.erofs 1.0
>         c_version:           [     1.0]
>         c_dbg_lvl:           [       0]
>         c_dry_run:           [       0]
> 
> mount enwik8_nocomp.erofs.img /mnt/enwik8_nocomp/ -t erofs -o loop
> 
> ls -l /mnt/enwik8_nocomp/
> total 97660
> -rw-r--r-- 1 root root 100000000 Jan 20 01:27 enwik8
> 
> *Original enwik8 file:*
> ls -l enwik8
> total 97660
> -rw-r--r-- 1 root root 100000000 Jan 20 01:14 enwik8
> 
> *Source code used for Lz4 and Erofs utils:*
> https://github.com/hsiangkao/erofs-utils
> https://github.com/lz4/lz4
> 
> -- 
> Thanks,
> Saumya Prakash Panda
