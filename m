Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B431A7B32
	for <lists+linux-erofs@lfdr.de>; Wed,  4 Sep 2019 08:08:49 +0200 (CEST)
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 46NYKp2Gy3zDqnc
	for <lists+linux-erofs@lfdr.de>; Wed,  4 Sep 2019 16:08:46 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.ozlabs.org;
	s=201707; t=1567577326;
	bh=MjZkSyv9gEXWWeTEjsgBXpbBmwnc1iaTPLoVwPZrBiA=;
	h=Date:To:Subject:References:In-Reply-To:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:Cc:
	 From;
	b=kyBQnfiLnhN6I4renSZO0WLqSuOPWkO0jrLBOHy2OQHCs+nzb48ZTXp/kHO8McGHY
	 7+SxnNUqWpkm+6fiEVUpBm8MWAdkAmmL5stxNQJNKgLfLRb78Plg4mBq4G7wHbbbTA
	 4yCEjj8bAgw8UXDs9n+ziYFoC56R/rELc14Fxb8FYHuJjNAS8OnXdRwIhTh6ytydKc
	 39wgQ9uQjDm0OPLbGCHOpTgUplKD021wWD6ZWKW2uNwuN+zrxqYrqqADq8jojAWfoS
	 z247ctDCV7UWsrrCaKh19YnFIUhGS74SA9SosTfjonEDnwhQHieJXYZbxvKc1iTT6S
	 YnCKztJIpr3zw==
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=aol.com
 (client-ip=98.137.69.84; helo=sonic314-21.consmr.mail.gq1.yahoo.com;
 envelope-from=hsiangkao@aol.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=reject dis=none) header.from=aol.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=aol.com header.i=@aol.com header.b="A+pfb8eQ"; 
 dkim-atps=neutral
Received: from sonic314-21.consmr.mail.gq1.yahoo.com
 (sonic314-21.consmr.mail.gq1.yahoo.com [98.137.69.84])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 46NYKf26zxzDql2
 for <linux-erofs@lists.ozlabs.org>; Wed,  4 Sep 2019 16:08:33 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aol.com; s=a2048;
 t=1567577306; bh=hwLoSYhXaI9y1p2SeQMw4UaD3K63yJIgvZMxCenrJ/4=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From:Subject;
 b=A+pfb8eQm4peOZ7svJ0j1Qo9AmvbYV20x/99EhMVcJWBNW/Q8hV7yoEd9tYpUsYIOKfWuQU7QwEaYCoW7IZkMMIvs2LmeCLa3+LvbTwjOKMMP4ZoeXheYAuCmxTWC3czBSoQdNTrCdwvcPy8okkVdN1fnT7mI7YkPD6fqmSM9POAyhJWFj8pP/Mo6k1DO3atKjeILLdQy2xwBiyL8h3ew56xmTwFfPxAHDK8iq5EJCcUo0uV8wCWG1ZqudfIAISgsux7uTzL/vd9/TBu94qB1uP3CdiN5NDoh18JFKErKZIZ7b9iTBqXDSsELOTaL/admA43Skk0979h2JuvnHpuYg==
X-YMail-OSG: ORKeb9IVM1kThrZ67B2VWu5_tzJzSqCtP6NT4Tejriu6270Qli6JTkfLt5XExMJ
 npk9JAOimvEeGPR2FCYFreY7PiGc1PxTtW6xyatHYr5qiruzm.9A_2_H6KiC1gis_eUQDKbqH0k3
 ORmm7NKBxpzdVqh7kUKZP7Sq0t9K3M_gnQ4iTY3TINJqrvq339IAJIpcgHRAbtauNtPJuRyTjnP9
 EFoNMXNefNQ9rzM3OjkI0ZpwxWL8opZkTMhq1VHh9U5P2sq00Pb2meb20fb7qR4OZx4iN_4amsL_
 d_1csYetXVlmbwbsZTWjur_k4l2TXyt6iLmflbNED_yp6JNq_6CDmOxp7zPuPlvfGnOlbL0SfSVD
 S7W4rJKwjJ2_U2e0vLIDR7BIWm0htHYmthv3Qmf499XCEIutE8f.1WJzW3H4FN_RuXFs2NMdXWWA
 GQQpUceT4AEfv2mGqgecbLqFkCsrp7IRgwceGRmKUH0HRonOVQ5T6hegQHi1.zINqb7vTYPOj1io
 SaNCU4iAZVoA1W4xMHDa65uUbIsfkg8eJ2V.OnQ0zJngFbJcodvv0IEH7wBzkvgt40Y1v0y6Wu9r
 7N40AsqavL_R7ZvZQkG1Diqu8x8uTu3hSw7622eBqS2u9_6zR1.XuIqBSi8buagzaGu0YTzGGwNo
 _iyE2hisIjMCdCwVAvAukEuqvqkIrKNC5WTlRjXJaItnVkgx5nc83HHvhsUmGV45Q0u91t8YfgYF
 hkEg1QUlfWQcgkW7LVNGblczxvNxV4xkcvD.8RQP5gPmESgJVjQL3cwHJxeB4hPj9Mprv.x8aVl_
 ZrTUgm6iftZJZxM075AZflisSpli4zMh_J6ersi7xePxE_O7czwk9UtyNWCAPYSjaQORjiVPnC81
 M1Qn5wmSoefAyATLZdwGSQOhw_XT9nlC9r6TBowxw9hoqQebRWAk8HtwTX8M.lZCTkMfxcTwJD2F
 mVJ8TlwipCnPgBjnqLThG9lD.b40HrC8hRkLKBwferwSgfrDJrcFI4ESxW0DG23LdG9mr6xGJxon
 OQDeGw_nqgBsfoVxGUogx5NZlB_T0TA8ayaa6Q7eDyPDhIUnZXCojjHenOI4Pgsi8hD2b2bqIbP2
 AgkJzth1_lAjPOBI2y4RoGvlRm9dyPQDCOsjHeBO6L73nnKw3WY0DfbeAHEwW_846tzQQwyu64_s
 4HqMqAj8htnMeFUKHR04vyCBQXQSv16jQASMbhnN6uStUZDWPOZqsrGt8GWnu7LZ0p8AUgc6MjMy
 CCLQQPWQw.SfOu36XKpMafrAKavQarNNPLkMFS6iozfh.fiAj5BuKR3fDG.RrCevPzcyeaA--
Received: from sonic.gate.mail.ne1.yahoo.com by
 sonic314.consmr.mail.gq1.yahoo.com with HTTP; Wed, 4 Sep 2019 06:08:26 +0000
Received: by smtp411.mail.gq1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA
 ID 3e160abbfe0b3ab899cbfee2cf1f96f3; 
 Wed, 04 Sep 2019 06:08:24 +0000 (UTC)
Date: Wed, 4 Sep 2019 14:08:18 +0800
To: Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH v2 00/25] erofs: patchset addressing Christoph's comments
Message-ID: <20190904060817.GA27072@hsiangkao-HP-ZHAN-66-Pro-G1>
References: <20190901055130.30572-1-hsiangkao@aol.com>
 <20190904020912.63925-1-gaoxiang25@huawei.com>
 <20190904051655.GA10183@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190904051655.GA10183@lst.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
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
Cc: devel@driverdev.osuosl.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 linux-erofs@lists.ozlabs.org, linux-fsdevel@vger.kernel.org,
 Miao Xie <miaoxie@huawei.com>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Hi Christoph,

On Wed, Sep 04, 2019 at 07:16:55AM +0200, Christoph Hellwig wrote:
> On Wed, Sep 04, 2019 at 10:08:47AM +0800, Gao Xiang wrote:
> > Hi,
> > 
> > This patchset is based on the following patch by Pratik Shinde,
> > https://lore.kernel.org/linux-erofs/20190830095615.10995-1-pratikshinde320@gmail.com/
> > 
> > All patches addressing Christoph's comments on v6, which are trivial,
> > most deleted code are from erofs specific fault injection, which was
> > followed f2fs and previously discussed in earlier topic [1], but
> > let's follow what Christoph's said now.
> > 
> > Comments and suggestions are welcome...
> 
> Do you have a git branch available somewhere containing the state
> with all these patches applied?

here you are...
git://git.kernel.org/pub/scm/linux/kernel/git/xiang/linux.git -b erofs-experimental

Thanks,
Gao Xiang

