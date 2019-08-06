Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B54083799
	for <lists+linux-erofs@lfdr.de>; Tue,  6 Aug 2019 19:03:32 +0200 (CEST)
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4631Dd3HGfzDr3S
	for <lists+linux-erofs@lfdr.de>; Wed,  7 Aug 2019 03:03:29 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.ozlabs.org;
	s=201707; t=1565111009;
	bh=7byVa89Wjxqr48e4qprl5BHB7qRvaU0nhL2Ugp8R8IM=;
	h=Date:To:Subject:References:In-Reply-To:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:Cc:
	 From;
	b=Sab18NXBCr/10kN+Z/qV+w6tg/xu5DyLwDgITAptxpwUAw5IkDTK39zcXoHQGaZBA
	 LcZRgZ9w+WEtIABRsP4UDdRCz5t2BTW4Kx84UV5BQWZhEZGOxQWwW21uGovImCIVRL
	 vdlOy9UpsYBqmjbD+TUfR6kFKZf0PgwpZQApyOon7NfpkPFM+QO5nTgUaybR9uLrvh
	 qcpgYQQiez94ls0Se9c3tqlsOttFK6SDiaykdUkPJ1vGw0LKLQa+S0EkfUeP+etyYK
	 HqEBIPquxEEIxRny3mXy4jPj63s9Ds0gzEV2Y6k3PXKabVAInn8BZ2bUAunuXyldXh
	 yN1EzczJ111TA==
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=aol.com
 (client-ip=77.238.176.99; helo=sonic301-22.consmr.mail.ir2.yahoo.com;
 envelope-from=hsiangkao@aol.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=reject dis=none) header.from=aol.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=aol.com header.i=@aol.com header.b="E24UfZNd"; 
 dkim-atps=neutral
Received: from sonic301-22.consmr.mail.ir2.yahoo.com
 (sonic301-22.consmr.mail.ir2.yahoo.com [77.238.176.99])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4631DW5YSQzDr11
 for <linux-erofs@lists.ozlabs.org>; Wed,  7 Aug 2019 03:03:19 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aol.com; s=a2048;
 t=1565110994; bh=OGfEqfx+PU4InM0VSbOYRNhJFzEA/rXojevv3mMEsbI=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From:Subject;
 b=E24UfZNd5y/93bIO8AIK1WRL5l3AvfcVQd++GnimXLA4gR252vHsJi8k20+oURzT9w3wS92yBC/DDjRFRS8YCdg0tAJAta6BEqaj25S18QcJzGxgwFJ8x/zEn6TGVWcErkq66KW4SS109tfLATR+tTPZzzAjN47ErRJyhPQjt8WrCTp1u2ILIXcPYMhf46fJksOYnJ9Mwpz62UYBK27V2PJRIqsU+Xyi50JGMntJ95v6ct6VF0xAUyT9e6k5KsABHuOsvTCdR78uqQLZVY3b7qL/awMnptKyM0TIaZBRKJMtwO4uhyAK2z7G1WcS2pu1y+gRANlCTFItOYh4bkgeBg==
X-YMail-OSG: sl1gkSwVM1mlHDEiCdaH5dj7rsgViEgTQ3a6APzIjZvHoF1PNh8AdYZocdONKXb
 DehHMC3hV8mbP2YRe6_SnmdQQtkOXiuatzZxsjswEf.dHL9RDFe52j3Ea.QU29gtRweDu7id2oKj
 hXXXElssWDQgY.XnofRaJm.RSJ2sFha5tiCVB8Nn_WrrGaZdX_Jqp2U8IxRQwBYaoxrXWp5J5tcE
 xYrjyrhQD0exM2ILMUpC4YQUPCeJYkdmTHhUC5vrgeT9Vzufc2V3.5GQCz84d7tugwqfGLUB3sxs
 s95K0Rn81hYEjC0wfFNwDC4H_VX_HUp4UJqFcwiaGkIAg8HRdaAUB.k6rF46KxvOlobREg3nGUsY
 mBRyWi0gPKRhJdk946XQ4TbieDTjNwUUmORU7PKqkefgBoBEJWSgD2VySrTya1ZAVZoJr6EE8pXT
 gBUQ87pm4doEnbtWwfM9XLJhaouK2jKB6fhWp7NxDiYOIQNer8_my3FtsUbtxS584m462LYqEJ6f
 4KrKgQPr534DA.p5fhxf6QbVPIppQMsZ5WPigBeajM9KmLbcmaMSQue2XaxHN4jwym_L6Owdman3
 NRlXrxqOOxfQl5ENsEe7AcvIOjXWQ1LD0BEkmB61nUwa2zh5jDnbCn1HM4LIssrWO72z_OjydP3K
 vC1ARwrEbZUllkReaxbmnk7PEQY2bd1r2Ya0NcSQ9Fem5pfrNGVQy5QfdCOcPbbWdHt4GiDKQyn0
 X3grpvJkl9QTKL4oP.G6D1suJaS2OLkFs8rKEKP4Xell0qSBC10f55SY1bQPzzLr7Mr6cTnsTxr3
 VkIz3d8TnFi8bVFDOtazRIsYNigMp3ohRsTf9FwSDRK7SblzKBF8bCoFbjDwbBPrEQLHwjeFFjee
 0ljSMjbIwfO_7RJq1oHK3NFTYo5_2n23HDeLukA2E2xkYQOOgtz_s4kSq0kqbtTZX9vkSFHRbV94
 uKQCtyV_ZEjLuyU.MCs2FhejKDQxoIJGUFYbFNMU9mXVX.iP_AJjv.1n.9s8H5dgk2HaeXlBmbQ0
 MuzYGTPsK6NIkofKI6bIxSVF1BfLyKjVBOlO1cQJ2TBGcLcyFrao6jAMC4iMOa9oTR5JlxZGh5yx
 k870EeUkAb1Hh3smqInaGEMA6u.FQErg037R3OTAJt15QCoKSFboc2d1EKe4Ywnxqk3Pq1CS8EZf
 hC7Thr59WMZjgZUzlmngacmH5IgHTpqRD_BGXn50aYE_bLCy8DRrm_fIMDqDQMR43gG4YiYf01Vc
 k68WnBIHCfPMWRieLByE9LBAWCw--
Received: from sonic.gate.mail.ne1.yahoo.com by
 sonic301.consmr.mail.ir2.yahoo.com with HTTP; Tue, 6 Aug 2019 17:03:14 +0000
Received: by smtp406.mail.ir2.yahoo.com (Oath Hermes SMTP Server) with ESMTPA
 ID af769fc35dd430e77b6ac1739d1acdf0; 
 Tue, 06 Aug 2019 17:03:11 +0000 (UTC)
Date: Wed, 7 Aug 2019 01:02:58 +0800
To: Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: [PATCH RFC] erofs: move erofs out of staging
Message-ID: <20190806170252.GB29093@hsiangkao-HP-ZHAN-66-Pro-G1>
References: <20190806094925.228906-1-gaoxiang25@huawei.com>
 <20190807013423.02fd6990@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190807013423.02fd6990@canb.auug.org.au>
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
Cc: devel@driverdev.osuosl.org, "Darrick J . Wong" <darrick.wong@oracle.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jan Kara <jack@suse.cz>,
 Amir Goldstein <amir73il@gmail.com>, Dave Chinner <david@fromorbit.com>,
 David Sterba <dsterba@suse.cz>, LKML <linux-kernel@vger.kernel.org>,
 Christoph Hellwig <hch@infradead.org>,
 Linus Torvalds <torvalds@linux-foundation.org>, Miao Xie <miaoxie@huawei.com>,
 Alexander Viro <viro@zeniv.linux.org.uk>, Pavel Machek <pavel@denx.de>,
 linux-fsdevel@vger.kernel.org, Theodore Ts'o <tytso@mit.edu>,
 Jaegeuk Kim <jaegeuk@kernel.org>, linux-erofs@lists.ozlabs.org,
 Andrew Morton <akpm@linux-foundation.org>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Hi Stephen,

On Wed, Aug 07, 2019 at 01:34:23AM +1000, Stephen Rothwell wrote:
> Hi Gao,
> 
> One small suggestion: just remove the file names from the comments at
> the top of the files rather than change them to reflect that they have
> moved.  We can usually tell the name of a file by its name :-)

Thanks for your reply :)

For this part, EROFS initially followed what ext4, f2fs, even fsverity do,
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/fs/ext4/namei.c
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/fs/f2fs/namei.c
https://git.kernel.org/pub/scm/linux/kernel/git/ebiggers/linux.git/tree/fs/verity/verify.c?h=fsverity

I think I can remove these filenames as you suggested in the next version.
I thought these are some common practice and there is no obvious right or
wrong of this kind of stuffs.

Thanks,
Gao Xiang


> 
> -- 
> Cheers,
> Stephen Rothwell


