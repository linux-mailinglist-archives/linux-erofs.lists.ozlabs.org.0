Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id CDE6A6C0996
	for <lists+linux-erofs@lfdr.de>; Mon, 20 Mar 2023 05:10:14 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Pg1V94mHxz3bT5
	for <lists+linux-erofs@lfdr.de>; Mon, 20 Mar 2023 15:10:09 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lists.ozlabs.org;
	s=201707; t=1679285409;
	bh=JYV7H64jfRymT5rzh2mlGslQT2jebjxqVf+uMCU2w2U=;
	h=Date:Subject:To:References:In-Reply-To:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:Cc:
	 From;
	b=OtSxTGvYvJRzL/xTzrHBlJ9DvTMFjBVNqUtQ4xoCeyXcZ13LDA5IfbLrC/+QCjASG
	 vnuuUF64/uOEalexarpYlXlxHweRkpqPaecnZYY9L+hxMaFF4LbeuxPWUMZDt8qnnL
	 cv9o/V+ih5Kh5GnhQBLIwb04cZTrOyehgw7sByMLXa9TE7qFHG4n2XqPLKDeoPMzRa
	 T+ee24g+PjaHeVxLoDEGNqPExJ0+YU/t+zkVsIrmsIxwgU+TmRcgiO1eSiuTXSTVlY
	 Yw0xNtHpmMIini3dBPBXg5KmIUqme3f7bcU6iRNF2Fu2ytBgxQUxeKcp/CeVZtWXZO
	 eY9E53shzEhYw==
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=opensource.wdc.com (client-ip=216.71.153.141; helo=esa3.hgst.iphmx.com; envelope-from=prvs=436eb87b3=damien.lemoal@opensource.wdc.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=wdc.com header.i=@wdc.com header.a=rsa-sha256 header.s=dkim.wdc.com header.b=PoFjYegy;
	dkim=pass (2048-bit key; unprotected) header.d=opensource.wdc.com header.i=@opensource.wdc.com header.a=rsa-sha256 header.s=dkim header.b=I0Nr6eY4;
	dkim-atps=neutral
X-Greylist: delayed 64 seconds by postgrey-1.36 at boromir; Mon, 20 Mar 2023 15:10:01 AEDT
Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Pg1V15Bc3z3bT5
	for <linux-erofs@lists.ozlabs.org>; Mon, 20 Mar 2023 15:10:01 +1100 (AEDT)
X-IronPort-AV: E=Sophos;i="5.98,274,1673884800"; 
   d="scan'208";a="230974289"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 20 Mar 2023 12:08:52 +0800
IronPort-SDR: wp95rHdu7L3u9dCChBl9zefoHhaBuGWnSBhFzf+3gFcuBHdHfzttkmC5C5byXYO8GFn0BPe2MD
 h/NDprsg8A334GQL6oM1Daq5bP40Y+XrOR0I4up/Hr0KZ3e/V/SpTjAzvRMozWkXprZcwfWkRo
 Is6A4W+3rSVWlb/TCUWT3QeLU0tnduZRRWwBRV8IwFfBJh1obib1W94o3c2EWWG8WsUcSwmZSv
 I9FXWphEN+ePz/0Gqe5lQ/1bvhIEZr0NTxjWiyGHL/g4iVzpnWqjmzBI3NXZ78gHYdX8YO0cLJ
 CEk=
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 19 Mar 2023 20:25:13 -0700
IronPort-SDR: hxT8cqNJcSx/g/vcIfrhkOCeb2HwAhxSY17UPOlhW8kIkADDAv97H3JaF5jD8chZPckQ2wDopC
 hUX6ASFjpukro7KsbVj0dEEscfn616ONuyawr24nZbRyfbMvW0NQKUYIH65BvTNvPSu2kDlkOq
 ft1Mt9mDlrlSKdiPHoAETP+TOurMb1jvanxtxl/8EYW6mMnNMZ/qZiN5N4khnfZ571ZVZSlkic
 e8KeeR5HU3T+e3h1MBielGUaS3bny+tmxv9JA2F1OH6F5ye8EvnVFthR/0lfU13bKXP6JLUtmA
 eaE=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 19 Mar 2023 21:08:52 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
	by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4Pg1Sh0LXTz1RtVq
	for <linux-erofs@lists.ozlabs.org>; Sun, 19 Mar 2023 21:08:52 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
	reason="pass (just generated, assumed good)"
	header.d=opensource.wdc.com
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
	by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id gFo2sIK9R2pS for <linux-erofs@lists.ozlabs.org>;
	Sun, 19 Mar 2023 21:08:50 -0700 (PDT)
Received: from [10.225.163.91] (unknown [10.225.163.91])
	by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4Pg1SY32s6z1RtVm;
	Sun, 19 Mar 2023 21:08:45 -0700 (PDT)
Message-ID: <e4b8012d-32df-e054-4a2a-772fda228a6a@opensource.wdc.com>
Date: Mon, 20 Mar 2023 13:08:43 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH v2, RESEND 01/10] kobject: introduce kobject_del_and_put()
Content-Language: en-US
To: Yangtao Li <frank.li@vivo.com>, clm@fb.com, josef@toxicpanda.com,
 dsterba@suse.com, xiang@kernel.org, chao@kernel.org, huyue2@coolpad.com,
 jefflexu@linux.alibaba.com, jaegeuk@kernel.org,
 trond.myklebust@hammerspace.com, anna@kernel.org, konishi.ryusuke@gmail.com,
 mark@fasheh.com, jlbec@evilplan.org, joseph.qi@linux.alibaba.com,
 richard@nod.at, djwong@kernel.org, naohiro.aota@wdc.com, jth@kernel.org,
 gregkh@linuxfoundation.org, rafael@kernel.org
References: <20230320033436.71982-1-frank.li@vivo.com>
Organization: Western Digital Research
In-Reply-To: <20230320033436.71982-1-frank.li@vivo.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
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
From: Damien Le Moal via Linux-erofs <linux-erofs@lists.ozlabs.org>
Reply-To: Damien Le Moal <damien.lemoal@opensource.wdc.com>
Cc: linux-nfs@vger.kernel.org, linux-nilfs@vger.kernel.org, linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net, linux-xfs@vger.kernel.org, linux-mtd@lists.infradead.org, ocfs2-devel@oss.oracle.com, linux-fsdevel@vger.kernel.org, linux-erofs@lists.ozlabs.org, linux-btrfs@vger.kernel.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On 3/20/23 12:34, Yangtao Li wrote:
> Hi all,
> 
> Out of consideration for minimizing disruption, I did not send the
> patchset to everyone. However, it seems that my consideration was
> unnecessary, so I CC'd everyone on the first patch. If you would
> like to see the entire patchset, you can access it at this address.
> 
> https://lore.kernel.org/lkml/20230319092641.41917-1-frank.li@vivo.com/

Hard to comment on patches with this. It is only 10 patches. So send everything
please.

> 
> Thx,
> Yangtao

-- 
Damien Le Moal
Western Digital Research

