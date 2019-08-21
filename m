Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AD1296E75
	for <lists+linux-erofs@lfdr.de>; Wed, 21 Aug 2019 02:40:02 +0200 (CEST)
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 46Cpht5F6nzDqTD
	for <lists+linux-erofs@lfdr.de>; Wed, 21 Aug 2019 10:39:58 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.ozlabs.org;
	s=201707; t=1566347998;
	bh=3L0ttFN6yuOqS3IgKoYwq0g+vZaJmZiiChWp5ZFA68E=;
	h=Date:To:Subject:References:In-Reply-To:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:Cc:
	 From;
	b=kKTi0H2wNvEAarHOQTa7J5sPAQ7d5NOULoozNf0NapL077aI0iSDmWsLXCainYykI
	 pqOOdDSadfUcFkIOfg9MqkUhU0zXhuUfD/mCju9sMC5D3UScGfKRdyYGJ97CJwkIuS
	 bf2jtZ0HLZDREqI3YQn3VfczhgAuYVNUWFI1Oep8AIViSb+P//7UoyfrOQX5ti+vV4
	 kVbkm3V5v/dY00JwGZ13UUbUrKF79vxBcD7e35Nc4u8JSsnrPsFTsxtlkcvu3cucx2
	 95ACoiZDtDxkHUPS9o9kFaZcl9eU30vYhLbZC3CjQTsZ7R8IhPyscQSRoqyaV/eLMB
	 Sc7LdcveJONwg==
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=aol.com
 (client-ip=77.238.176.164; helo=sonic311-32.consmr.mail.ir2.yahoo.com;
 envelope-from=hsiangkao@aol.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=reject dis=none) header.from=aol.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=aol.com header.i=@aol.com header.b="cjO6zdAg"; 
 dkim-atps=neutral
Received: from sonic311-32.consmr.mail.ir2.yahoo.com
 (sonic311-32.consmr.mail.ir2.yahoo.com [77.238.176.164])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 46Cphj1HKjzDqQM
 for <linux-erofs@lists.ozlabs.org>; Wed, 21 Aug 2019 10:39:46 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aol.com; s=a2048;
 t=1566347982; bh=dBz1oFdgnI/WKEGr74peQBzy6c6LbhKbyJcmv8I8LL8=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From:Subject;
 b=cjO6zdAgZdoP/eR+2UwDbg4EHc7L79a8eHYvW6+PLb3NU/onSAymNusV/OQtMwCdgAbGu5Vel7ABoJcwS6+KQz1nyRlW9+33t3I2ykkDehqpkjh/5NyI/t2YcN29kXf/8yj5rn9sOmkevQCPukD78x8F2gAHfvNU1j8V/N2n+haZrDJPGs4ZzN41c7H0yop1x1p3N2pFo2M63WyW+SfVU00T2fO+FXxJ6vnbSdHQPfQWPlwerb4LADYF439OBOZ+alPE5Rpou+tauQWpUIs426kvr/JImM9FNO6IQ2R/1+C4/Gy32yvkfqotGbwpwvg86dVmqI/ipBzoluoWhoZIgw==
X-YMail-OSG: .HtFFrsVM1m6qxT_kGxPkFMO1nJ9npRODAPvKCtCYnCvOjsoN7lJpSs1yEh.JlM
 aPvjkilVSpUpBTe5FhGM8myRDj9y.Hvt_abptFP16G3ycLR7ZZqLfAZ081TXy876P5x5gpDFHqUg
 NBgUHnR8BpFeMmpkQtuMEYrrFqdHQfAENM2ocH0_kFhlKFwvoWGMHEmy6zOHDPQPi0onR4v0Irtq
 4zgYalI0OBZckbpn8mwd_RHYHhXItkFXFeh6lP8Oz76AgklOps0zvr7M0JHxWx6JTu_ZoTevUEN2
 _kEcHBfYgeXIRubAXkkml6.2QCTRfE657BNliFnClP9w1MxKJnLx0X0vA8EnN0VTPAnb5euUsMF8
 ODxliNVZ4lAmzKF6bgN9cm_EnYLzMHPyfITaKR1BhWMAagitSIp2tPETh_oGT5ayeVQbMy7MjXoy
 di5mEQ1ylQDST6CIzUQdo2o.oIa7keucoLL3xSUfshKFE60X4k9k50naVkDd4nVQJ7HmmgkA8YfI
 VWAZCOfT_iZ7_XtaEX1fYeBEAoIwiA0ZDEwazERPEoeTrX.bPi88cvmz8BehOPH3PbX4eL7llnSb
 ZEd3Uspd_.e8q.Eje1VH2AYPCWBDApMbc9c.kbjPeGR4gLDbMh7hegEDg6.vzNj.XHi3vNJHX.29
 apPZdMfViWtU1NryPvxpdLRxjxqqnI4eRMhW6UpiUW1gMc4WCwcXF6v7H4jnxXTtt1WSnCXob35g
 ytGIEE4qlzGnf5mddo7ivWrxcnwAUupipJGQDG0BLICWlRO3nAB8AcuHuzMNkQjPTEwiwldVRkcO
 c4UAty8MlhFte0CHpjrMBNdcyZa27aFrDXs_vgGV.fi47p7xI.AQ3hivjzAbLV0rTvDh8bGSfp_Y
 Ryqyq42K1YaxcCdHqdSKKXEZ5aiDDK_3gRk1v.aRfwBTmCL.0NlDSxJg19.ZtpntYAi.8DFzgnmB
 IZARlJBF5VjRT.uYAL44vnJlsCqsyNFcK.L8n6TirJ36gkee1R4IpVJttouwH1gLfeEGlCrszUFK
 r9HRz3fGS7moHe7LClIpSyrmf8aousPS8ef8MTHyKXO9MfpzAeJD9hwCo4Fjzywa3w9PE.Jt3709
 _AgVoV6UW.xTAzjPcIrWNpCkRLGPhILlKYU10jk8s8jMLDxnE2RoNgnkEvBJGrceEnFnr1JHZ2zZ
 66ZxHV9SXHbKAsGZQ3MVLeXSmmI9pADk.a2nJ3.BnTdho6UpQCz2BDCGpO1gH_7RwpX7X2CDya2x
 CHgJHxvKyVJxWWZnSJbbQ_YBMroxGTak-
Received: from sonic.gate.mail.ne1.yahoo.com by
 sonic311.consmr.mail.ir2.yahoo.com with HTTP; Wed, 21 Aug 2019 00:39:42 +0000
Received: by smtp405.mail.ir2.yahoo.com (Oath Hermes SMTP Server) with ESMTPA
 ID 79fa87127151e4dc10a6f5a22ec543fa; 
 Wed, 21 Aug 2019 00:39:36 +0000 (UTC)
Date: Wed, 21 Aug 2019 08:39:29 +0800
To: Caitlyn <caitlynannefinn@gmail.com>
Subject: Re: [PATCH 0/2] Submitting my first patch series (Checkpatch fixes)
Message-ID: <20190821003717.GA18606@hsiangkao-HP-ZHAN-66-Pro-G1>
References: <1566346700-28536-1-git-send-email-caitlynannefinn@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1566346700-28536-1-git-send-email-caitlynannefinn@gmail.com>
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
 linux-kernel@vger.kernel.org, linux-erofs@lists.ozlabs.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Hi Caitlyn,

On Tue, Aug 20, 2019 at 08:18:18PM -0400, Caitlyn wrote:
> Hello!
> 
> This patch series cleans up some checkpatch fixes in erofs. The patches
> include balancing conditional braces and fixing some indentation. No testing
> done, all patches build and checkpath cleanly.

I think you need to work on the latest staging tree or linux-next.
This patchset cannot be applied (there is the only valid place in inode.c,
I will reply in the following patch.)

Thanks,
Gao Xiang

> 
> Caitlyn (2):
>   staging/erofs/xattr.h: Fixed misaligned function arguments.
>   staging/erofs: Balanced braces around a few conditional statements.
> 
>  drivers/staging/erofs/inode.c     |  4 ++--
>  drivers/staging/erofs/unzip_vle.c | 12 ++++++------
>  drivers/staging/erofs/xattr.h     |  6 +++---
>  3 files changed, 11 insertions(+), 11 deletions(-)
> 
> -- 
> 2.7.4
> 
> _______________________________________________
> devel mailing list
> devel@linuxdriverproject.org
> http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
