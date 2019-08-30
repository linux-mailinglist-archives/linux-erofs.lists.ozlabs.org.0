Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2ED76A363B
	for <lists+linux-erofs@lfdr.de>; Fri, 30 Aug 2019 14:06:32 +0200 (CEST)
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 46KdVr5nvGzDqw6
	for <lists+linux-erofs@lfdr.de>; Fri, 30 Aug 2019 22:06:28 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.ozlabs.org;
	s=201707; t=1567166788;
	bh=2KTWx79IbkS7jvCuPQzksUk6MDz/328fKKwliW1zrtE=;
	h=Date:To:Subject:References:In-Reply-To:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:Cc:
	 From;
	b=Z2qh/jc91FEt3BzFDIRsoYMmt3WzYLvb/FgJDnAdJERYwyh4j9k5bSYkEgjdy6nwZ
	 vVQE+iD1rOhvBTpEqpWH18ZRUZEFVKgUMt9O8cZhEQJcOxf62hgm8W+MXuVsDoiuuQ
	 R4k7l5XMOhVQh3ryIBsviNcLARcxgVArHd4YQ+Y8itw6alAeWNmLOAtujoIaXBgWkQ
	 +xFuN1YQTNCmKCwdA2sAYI7WDLGzeZmBGeYGhdIzaTXjmv8fFdwfiBh0ek7oy5uWHX
	 gprVHoU4CohIJlYeFPbdl/gTvZ21q5p7JPVcNmPT98sDr6s53yX4nktXT6NXLDf0UU
	 cmc9Hp/o5HPpQ==
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=aol.com
 (client-ip=98.137.64.205; helo=sonic303-24.consmr.mail.gq1.yahoo.com;
 envelope-from=hsiangkao@aol.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=reject dis=none) header.from=aol.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=aol.com header.i=@aol.com header.b="XPYhccin"; 
 dkim-atps=neutral
Received: from sonic303-24.consmr.mail.gq1.yahoo.com
 (sonic303-24.consmr.mail.gq1.yahoo.com [98.137.64.205])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 46KdVl2P90zDqvL
 for <linux-erofs@lists.ozlabs.org>; Fri, 30 Aug 2019 22:06:21 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aol.com; s=a2048;
 t=1567166778; bh=hGegLswRsXDMS7Mt0Mf9JkYB6NpI8ypuxStTJrsPGuE=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From:Subject;
 b=XPYhccin0vNwy0qHU/AFTWVWWumy4xlu62gU/kiwuUoSqccL/ITAYQfsT9GOtawMrO6JpuewW8xTsbQ0K+IE1P0OK1p3dlFFmA7oBIRozcBGpxAxoweipZ6Hjf0lZIfZwP+B+ZwSd0lyf26Tz1Lb3lIHfIJUEwD6qm8gALrCt6YNkQ5Zw2Hb58z6MIzzzNXNcUUlOl98VnHwRgFWAltTinKnARKy0UWZg7pYVosX0/k91Ko2F+9/kmbQMOOsH8Qqr95UOzIr2fgy2wwa78Z8MyxHnd321+TudzHx3F8X4iKgj5R7FgRZtXxjI8DeX70HdBMMIQnxr+A9RvPUosm+9g==
X-YMail-OSG: n7uX8fwVM1kpk7u0piUdmYrLH_5BBhUDBSNQd97K.Kneq0njub_LkIXQ7gDURbp
 1JG5yVYKXHMcVq2P2Pwvr6tfUZ84yLbsUH18ynkMR8x50aXD2KUBVMux3qitqGbXwIfi2vgNFASf
 HNLNJl7aSQ7bJokzgnWM60lfcWZqjkerLFWKZV0mDfGjZavIR_pQz63xIeDheWxqwkAbUa7vjKAu
 C_r6zNVenso.eP34gWhvnCtpkeN9scOPp7457MFWsrrE2GEbaImWiHf4CZfev7vkiI6Dflp.wetb
 3jHaY2y9C9DgnjRfnZSnfaDEyOkjlrPrlklDeEirfcUAyIxsqNBfYozJmR.._K8bW9KmJtoKzq3N
 iRoNCI1hVqBIfDuA7PHDFRaM0fITssZURRpvFM1Dq6VpdtIU.RIEs_CraHjun8aSrXeSosCZ7mRi
 5Xe8oM1dw9Y571MR6iguM2Q95_D.1VLYZMMM2hNXzybUVolDJH7UtocP8_Ug7aCOseZtOfGJvd6e
 ADU.KWtv88Ts2OZuVspPL4vrBvHmywXBogxA81GLyEq8iIlaaICpdcrfC46xpfnXCNl85md5pG7z
 V4ln6zDzYSe5SgNBCoAOdyqZcPMZ6ja2pCq7T1xQzDefnZofKx1rk3mY1P1KwSlXFlClalTDzqNy
 S7g33ExlvnR0NbsuMD5Tjv4YhwC8b4lUJ77okhXGWJ4iZC5kUeVy9Bui_65NJANxpb4ZjYNJspx2
 _H9MbxdCtkse1hfCSIFwtq.qVEPXmFpPx04uYOy7piWiZMLRSV_zWEktduCp.HftEgVKZFpX_F.W
 GPl4d2YVsE3G1z6iP.2_9y8bgEnN34qQ9qlJs17NWNoEq28eU5noISOv1lUXeWgCDk8LpaZrGLzV
 0KU4R7w8Z02F3df7egyCvIZVnmu.V8huCRkrplLgwByuvHs9_zPKbgueNcqNVLdj7HzWajD1E7hY
 gp2NVF9pmrxaAypliSgt0rSAnOVbGYw7_WYpbOnf9eLafigu3JmfTPuwwxi0rgZNmZ8W9HQN2Z40
 n4EB7ykmOkVq03fvjIYIas4L5hbYZZBT8GBrEmVkKDwGdNxY72ZhAJTpaeHbsp90JIFk2eoH8rON
 Tt3N0jpnWgfshM2qavDU44SU3u35In3DF5lTsYrashl0SjStUN9Bquw3rJHYgLB.mCDfu4zh6J9l
 jxBdV1es6ULUQVLDVP2WxfQNgnVV9Bbs0I1jmtoNUol58WyFAV8zG5a5EtGNJECL49RFtEXwB0R2
 a1Pgqh833px_HmEH195a41YfEZZg9dzAB5AE-
Received: from sonic.gate.mail.ne1.yahoo.com by
 sonic303.consmr.mail.gq1.yahoo.com with HTTP; Fri, 30 Aug 2019 12:06:18 +0000
Received: by smtp408.mail.gq1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA
 ID 27fd797655cd7ababf61147ca3d721bf; 
 Fri, 30 Aug 2019 12:06:14 +0000 (UTC)
Date: Fri, 30 Aug 2019 20:06:05 +0800
To: Dan Carpenter <dan.carpenter@oracle.com>
Subject: Re: [PATCH v3 6/7] erofs: remove all likely/unlikely annotations
Message-ID: <20190830120601.GC10981@hsiangkao-HP-ZHAN-66-Pro-G1>
References: <20190830032006.GA20217@architecture4>
 <20190830033643.51019-1-gaoxiang25@huawei.com>
 <20190830033643.51019-6-gaoxiang25@huawei.com>
 <20190830113047.GG8372@kadam>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190830113047.GG8372@kadam>
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
 linux-erofs@lists.ozlabs.org, LKML <linux-kernel@vger.kernel.org>,
 Christoph Hellwig <hch@infradead.org>, weidu.du@huawei.com,
 Joe Perches <joe@perches.com>, Miao Xie <miaoxie@huawei.com>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Hi Dan,

On Fri, Aug 30, 2019 at 02:30:47PM +0300, Dan Carpenter wrote:
> On Fri, Aug 30, 2019 at 11:36:42AM +0800, Gao Xiang wrote:
> > As Dan Carpenter suggested [1], I have to remove
> > all erofs likely/unlikely annotations.
> > 
> > [1] https://lore.kernel.org/linux-fsdevel/20190829154346.GK23584@kadam/
> > Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
> > Signed-off-by: Gao Xiang <gaoxiang25@huawei.com>
> > ---
> 
> Thanks!
> 
> This is a nice readability improvement and I'm so sure it won't impact
> benchmarking at all.
> 
> Acked-by: Dan Carpenter <dan.carpenter@oracle.com>

It seems Greg merged another version... I have no idea but thanks for
your acked-by :)
	https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/staging.git/commit/?h=staging-testing&id=8d8a09b093d7073465c824f74caf315c073d3875

THanks,
Gao Xiang

> 
> regards,
> dan carpenter
>
 
