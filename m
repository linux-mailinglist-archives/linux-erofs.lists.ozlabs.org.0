Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	by mail.lfdr.de (Postfix) with ESMTPS id 30BB9144AD4
	for <lists+linux-erofs@lfdr.de>; Wed, 22 Jan 2020 05:37:36 +0100 (CET)
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 482Xgx3GXrzDqQX
	for <lists+linux-erofs@lfdr.de>; Wed, 22 Jan 2020 15:37:33 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.ozlabs.org;
	s=201707; t=1579667853;
	bh=B3BborpEB37b8TjbSmAH3Aoyqx1FhZnzornC9JyvmQY=;
	h=Date:To:Subject:References:In-Reply-To:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:Cc:
	 From;
	b=PqB03dNHh/zytzCr+6d7li7ctyW5yZek9iAzhbdj0FEofDmvNuH5vHDwOLnMy/hPi
	 Gkl5Lm4de1puPraydx17DTmJtJqzToNmGVWzqlWNWKhpoiQf5qY6U8U2IbxlHz2VtP
	 MpCxjPod34k7QtG32yXGyhTl/kx7A/pzWIAF+rPk33Ms4hQHcC9PEzS4KR0TUfn0Gd
	 F9ztzgnYM92HKMp3ClQpv7KXsSSn8fXUMOZ0Bg02/CoXpoAZo3KJwM/ywAFFieWJSc
	 U7Y7sszmwDMjRjOmz7MhkJygPARAwdx+BLkf8J6TgRi3BUgsBBXzGsP22Ihq1cplKf
	 a7tL2gKbIFKwA==
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
 spf=pass (sender SPF authorized) smtp.mailfrom=aol.com
 (client-ip=98.137.68.146; helo=sonic302-20.consmr.mail.gq1.yahoo.com;
 envelope-from=hsiangkao@aol.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=reject dis=none) header.from=aol.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=aol.com header.i=@aol.com header.a=rsa-sha256
 header.s=a2048 header.b=E2dlkmDy; dkim-atps=neutral
Received: from sonic302-20.consmr.mail.gq1.yahoo.com
 (sonic302-20.consmr.mail.gq1.yahoo.com [98.137.68.146])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 482Xgd5JybzDqQ4
 for <linux-erofs@lists.ozlabs.org>; Wed, 22 Jan 2020 15:37:15 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aol.com; s=a2048;
 t=1579667831; bh=y0kltOs44ya5MkDp5Qoku/FNKJEQ9FndGwq7CWlx5MA=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From:Subject;
 b=E2dlkmDy1kAQgsSV3d/b+Rjo06in0ASXvKTFbyLDJnHuK0Ec5n+3rvljkyyV5mz6pJSMS/yNnasiXbzTNtqYFYDMn01GbmZPNSrj8q6M7VtbszBltdr58Db91PL7v2n3B3daHlCAzYJ9C5Vf7Fc+5I+l367/9DAe57DRtbpWhx4BwfpUwL6/7r6oSXAep25I2zMcTr6prkcP7kMmCJH9l8rjKLpzwfPN5UjINnmmwns7mhc4/h4MP5UhndjcPEDFwvsLff6VK2BaBGiM33cXTd1S3uzMkN84ZjOf+SOXcQNv2ALBygRT/kFW9HtalFVwpiE7FRFfscC1KVmxbrQUJA==
X-YMail-OSG: 32tAxI8VM1nMeqUpqcqoX._fcyj.sEKlmECpcEIZPCiyJEaV9gOj_JcsLf3v0DE
 DnFnqz6W2q2Nrf8h_Exla3i_Jps.Jkqra3fskMzWZKPdlDmgQ8zcus44fz2LZQ50QHTjVL2gx_3k
 uBXGZQK9A2DMofm8jswtx9Aj_1eVim_YtZRSe2bjROAf_e5jKEvzgjR4xb2sbgVurT_pU3NONLZ5
 ANpUBB5Fgt51z.XRDNrpLOu63W_mZ4f3JO..xuV.Ccb7dSw9h4JSQ9_fYPgPGl9_OOnUZ2y.alfG
 GJBZ4oe5XtEUpkCzD.E4iGGIobcOWhSXxhBLItS5MbGA1ILQwWB.Qj1drqSLeeo2LsiSwVNWSN9p
 4yY51IK0RLxJOfvxXa3lTud1qrnL2XPqYWeNbqWMvCQSaErdmOaOXbD5aaRVEmBOO1WNxEgAeqCG
 axksftEk6Fff6uwMGBn_t3zoHkAY7H6OznCsrp.MqJHD_6LEWZOEKvgCY_uq1bsy2G.JZ41HlVTD
 .zCtMoiO_5.g.oRTC1EnynuvTu2tAQacPrrKElUNMIahK9PC2rhYVdB53s3pBHdK0cfU4AcT9b9S
 .WEa0GEgdY31O12tD6xYLeRVOJEMEksXW69pXEX.LcgI26E_ZbkScqH87Hr8OIyl0rJQZBXi0bn7
 YrIswxIynFScyAG5ij0dcJB9dMQSSn42OXisjneJWlJKZFYkkeyEMKbkS1bPWV9ggu51JVUdW8tV
 nIwgWCcwNThpsmB2NZKHDXkFz9qLPFuFd_MdA5Uh_YfzC9TTG5MotVaqyF_tQYHH07BejQmTEZfo
 x5_tUJwewAiGzjlW9M3CtpRKhwu25weJbkjmw.IaZuRdq9rmiQ6ulj5L4Xm1GHyB9TBOR5qMEBDC
 GbqSrQlvJAw6FD_1DMfNqI6dvrl5q35w5mMYpHTK9uvDwQTtKA7Fk82nWhtKK_9DwHUIDq4swM9S
 A_A7.6M9rojjRQfz9QvAQS_XcuBXLIsZAOMONZUDsf1eeG8J2hFdtAox9O9rKHoo0Qd2NT_aUkU.
 gwLJ7Odo35LiQ49hTUvaNNSxwW0iugAQgWnJ6gemKCFNZ0htssYhW4KNEk6kkjw2rZvOWAfmkajt
 bieQ_.bHsscY549junjoyRp85Lk_VNmJDgUvR9SlnlKhMTTua_4ypA0Q5GmMUbxVcapm8QKVXyJX
 egrYlnQygUYW0ru1B6y.0oaWXfSQcOXWmqigbZRyFjRXFNQyz6lo.nkXTAUHmXjwchUNE2h_BsRR
 G.zvnBm0BGzjmEEVPhZhZ81hxzHwvq_0IiskwWW3I8b2iHlg8E3mD.IZrHRrqsebnQt0k9l7hWAi
 Zwj1n0y1deA9ayBWyTobUI6sudAslw27YYw2H6Wld2HIB.2Rte8YfUfxmg2lLr3dqbTtqOHQEKAA
 WBl6bYhyqX1JeE.9gECfu15zVbzFmbNBgFhZk_gCN
Received: from sonic.gate.mail.ne1.yahoo.com by
 sonic302.consmr.mail.gq1.yahoo.com with HTTP; Wed, 22 Jan 2020 04:37:11 +0000
Received: by smtp401.mail.ir2.yahoo.com (Oath Hermes SMTP Server) with ESMTPA
 ID d0534db1d9f8f83698a32c8ac31bb089; 
 Wed, 22 Jan 2020 04:37:09 +0000 (UTC)
Date: Wed, 22 Jan 2020 12:37:03 +0800
To: Saumya Panda <saumya.iisc@gmail.com>
Subject: Re: Problem in EROFS: Not able to read the files after mount
Message-ID: <20200122043655.GB6542@hsiangkao-HP-ZHAN-66-Pro-G1>
References: <CAHmfoRm7xUwuXfTZ2kr-x9fs59x7b707t183ggbLEtEyO_wznA@mail.gmail.com>
 <20200120073859.GA32421@hsiangkao-HP-ZHAN-66-Pro-G1>
 <CAHmfoRn+YjEwxmZLTeDVN9Oja=7QTi14oEtpD5x7URT_X9dJ5w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHmfoRn+YjEwxmZLTeDVN9Oja=7QTi14oEtpD5x7URT_X9dJ5w@mail.gmail.com>
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

On Wed, Jan 22, 2020 at 09:27:45AM +0530, Saumya Panda wrote:
> Hi Gao,
>   Thanks for the info. After I enabled the said configuration, I am now
> able to read the files after mount. But I am seeing Squashfs has better
> compression ratio compared to Erofs (more than 60% than that of Erofs). Am
> I missing something? I used lz4hc while making the Erofs image.
> 
> ls -l enwik*
> -rw-r--r-- 1 saumya users  61280256 Jan 21 03:22 enwik8.erofs.img
> -rw-r--r-- 1 saumya users  37355520 Jan 21 03:34 enwik8.sqsh
> -rw-r--r-- 1 saumya users 558133248 Jan 21 03:25 enwik9.erofs.img
> -rw-r--r-- 1 saumya users 331481088 Jan 21 03:35 enwik9.sqsh

Yes, it's working as expect. Currently EROFS is compressed in 4k
fixed-sized output compression granularity as mentioned in many
available materials. That is the use case for our smartphones.
You should compare with similar block configuration of squashfs.
and there are some 3rd data by other folks as well [1].

In the future, we will support other compression algorithms and
larger compressed size (> 4k).

[1] In chinese,
    https://blog.csdn.net/scnutiger/article/details/102507596

Thanks,
Gao Xiang

