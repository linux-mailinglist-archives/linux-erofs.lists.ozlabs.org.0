Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 44BE8987242
	for <lists+linux-erofs@lfdr.de>; Thu, 26 Sep 2024 13:03:20 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lists.ozlabs.org;
	s=201707; t=1727348596;
	bh=VwmcymaLIVsDVs11KOkEWK+mEleMwxNi6ljbNL5tNxA=;
	h=Date:To:Subject:References:In-Reply-To:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:Cc:
	 From;
	b=iV4jkwn8za4Kq58Viwbhhcx5ygWp2wf6eAUDL0Pa+mPp1BULHThtovTDPLDWbsfgb
	 sJpO+Bhun75eGwcwtJY2fet3zb6egldfHpmkL4UefltS2kstcVpgxsZsY5TVkbu9Vg
	 FcJ0nhXe0fvWkoBsiZxZ2wsZ7XlXTLjqawLrrc191+9VZdOYGuceJa56zlhYbx6lcx
	 oa4c/2ZhC+3zqpX/c5mQJYCPBMtOf+la0SZYNChCPtCj48wTwBtZKYj7EqgdN+JVw6
	 IDz4swR9E59aU/15/6hyaSzv3PwyVqBimsASHxlhmueOvlc7b0XYMLfOEX6kQeA2SX
	 a5GuW7GuNldyA==
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4XDrLD3Ynyz2yng
	for <lists+linux-erofs@lfdr.de>; Thu, 26 Sep 2024 21:03:16 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=173.37.86.78
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1727348594;
	cv=none; b=Vjqovqywjzg+eFHEqKpEprNi/YaODlr/ckM5BhBthgumrefunz7qJGMYzhTqp/IKBANiBoyjOpD0xLCMXKeIIZQT2h3xcS2JMy8uQfz8EaXs+ToPK9L5SkinrB7JCoepQ5wTP/VRwOeO6ZvApi7bhQfa10W1V3fiGanarBmmqvWXLjsRDOQfFLtbCQ87ihdfPJc3pCTBz2ldcpH5dbkybkSYAIE+7J1qSCMSMI99pepX6+2xg0dDDEBpaHJYSr0jebfGrXia3maAqDCbM0nEg99KLWyyvKrmUrSpjUUnpy1bvTLAx1QWvDUebT06/ra7dTvIUtXIpS9vE6icJCRepg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1727348594; c=relaxed/relaxed;
	bh=VwmcymaLIVsDVs11KOkEWK+mEleMwxNi6ljbNL5tNxA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eVa2nc32C+IrMEZ2QjnEfKvTLDdtxwqXYCXX6uMtNKWgT90XD+zSbPnQeGj3aqJsrdqEFBcS1bsZqfxYo0DDr9otk79PhPw2qhEM27DLspRl7+aPlQvZIWntdaTbo7LH3yO2rAszT4zxYAkkgGN0oM2WUla37/IeNuQ0HBNXts8gjtq+tVfuIOKCMVS3+yMqoB/ABk/W+NlJHxOvoQ8HbYU2nwwjS49Ko/0f+eZGJiJjWcMg09p5WH0TDYLRTLuhaGJBBQWI56oLztSAGybqjJliZdTOLk9no6SZ+P7kAYoTMjvpqiKdcQ1rvBWzludTSmhhE8573siYay2v62UpqQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=cisco.com; spf=pass (client-ip=173.37.86.78; helo=rcdn-iport-7.cisco.com; envelope-from=amiculas@cisco.com; receiver=lists.ozlabs.org) smtp.mailfrom=cisco.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=cisco.com
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=cisco.com (client-ip=173.37.86.78; helo=rcdn-iport-7.cisco.com; envelope-from=amiculas@cisco.com; receiver=lists.ozlabs.org)
Received: from rcdn-iport-7.cisco.com (rcdn-iport-7.cisco.com [173.37.86.78])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4XDrL43sC3z2y8Z
	for <linux-erofs@lists.ozlabs.org>; Thu, 26 Sep 2024 21:03:04 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=cisco.com; i=@cisco.com; l=6099; q=dns/txt; s=iport;
  t=1727348588; x=1728558188;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=VwmcymaLIVsDVs11KOkEWK+mEleMwxNi6ljbNL5tNxA=;
  b=Vop/mIGQ9NpyGAG60aPMppEjqYdg9f4OWhufwOLnGD8YKprS+Km9E5ok
   kOvMmMK+ZBExTpG2F8TwUqSHB5RjHsjpt5llL3iQ3WdsOq27vf1nSFbEx
   vYCVFxkxkweW4rPYea/L2Ifg0yZoLm7DkHqT5yWGskQqkg1PYujHnVG9K
   c=;
X-CSE-ConnectionGUID: 78TfVYHnS5m4jsVrh9GCnw==
X-CSE-MsgGUID: xN7lmGrHTZC/96YUSTadUw==
X-IPAS-Result: =?us-ascii?q?A0AJAABCPvVmmJBdJa1aHAEBAQEBAQcBARIBAQQEAQFAg?=
 =?us-ascii?q?TsHAQELAYNAWUNIhFWIHYcwgiIDnhWBfg8BAQENAQE5CwQBAYFyAYJORgKKB?=
 =?us-ascii?q?QImNAkOAQIEAQEBAQMCAwEBAQEBAQEBAQUBAQUBAQECAQcFFAEBAQEBAQEBN?=
 =?us-ascii?q?wVJhXUNhlsBAQEBAgEjDwFBBQULCw4KAgImAgJWBoMUAYJBIwMRBq8FGjd6g?=
 =?us-ascii?q?TKBAd4ygWyBGi4BiEoBhWYbhFwnG4FJRIQ/PoIoOQEChTqCaQSKCD+BTIIkR?=
 =?us-ascii?q?YJ+D4IagQyDekQMMgOCTWYWJU1VhxcncIQXjGdSe3ghAhEBVRMXCwkFiTgKg?=
 =?us-ascii?q?xwpgUUmgQqDC4Ezg3KBZwlhiEmBDYE+gVkBgzdKg0+BeQU4Cj+CUWtOOQINA?=
 =?us-ascii?q?jeCKIEOglqFAFMdQAMLbT01FBusO4FbSIIFPEQkAisBKQIFdhaBLDqWBo5io?=
 =?us-ascii?q?QOEIowWlSZNEwODb40BhkSSe5g4Po17mngCBAYFAheBZzqBWzMaCBsVgyIJS?=
 =?us-ascii?q?RkPileDVg0Jg1iFFLlOQzICATgCBwEKAQEDCY1SAQE?=
IronPort-Data: A9a23:JXJ+fa5/JKijbm3TN1Q+6AxRtDbAchMFZxGqfqrLsTDasY5as4F+v
 mUeUWnSM/mKazemKt8naY6y9E4PuJaHz4M3TQpt/HhhZn8b8sCt6fZ1gavT04J+CuWZESqLO
 u1HMoGowPgcFyKa+1H3dOC4/RGQ7InQLpLkEunIJyttcgFtTSYlmHpLlvUw6mJSqYDR7zil5
 5Wr+6UzBHf/g2QoajNOtfrfwP9SlK2aVA0w7wRWic9j5Dcyp1FNZLoDKKe4KWfPQ4U8NoaSW
 +bZwbilyXjS9hErB8nNuu6TnpoiG+O60aCm0xK6aoD66vRwjnVaPpUTaJLwXXxqZwChxLid/
 jniWauYEm/FNoWU8AgUvoIx/ytWZcWq85efSZSzXFD6I0DuKxPRL/tS4E4eYt0k9NhGIWd1q
 PlEKiszdBDSqMmw3+fuIgVsrpxLwMjDJogTvDRryivUSKZgSpHYSKKM7thdtNsyrpkRRrCFO
 IxIMnw2MEiojx5nYj/7DLo3meajm332aBVTqUmeouw85G27IAlZiuazaIWJJozXLSlTtla++
 WbD0H7ZPiMxc43B+Ae+znugu/CayEsXX6pJSeXnraQ16LGJ/UQPDwcIXF+3utG9i0ijS5dRL
 FES9iMyrK80skuxQbHVWxy+vW7BsAUQVsRdF8Uk5wyXjKnZ+QCUAi4DVDEpQNYrsskxAzgtz
 USImfvxHztzt7vTTH/13qmVtzSaKyUTLHFEYS4CUBtD5MPs5pww5jrLT9B+AOu2g8fzFDXY3
 T+Htm49iq8VgMpN0L+0lXjDgjSxtt3EVAk7/S3TX3m59UV+doqsbZfu7kLUhd5PNouWTVmpu
 HkChtiQ6/0IAZiRlSuLBuIXE9mB/eueLHjShkQqG5gn6iSF5XGuZ8ZT7St4KUMvNdwLERfma
 VXCkQxY/o5cIXzsa6JrC6qxEMUjy6fjHNPNUvHSc8oIa5xwfgaN9WdlYkv44oz2uFInnad6M
 pCBfIP8S30bEq9gijGxQo/xzIPH2AhhlV/de6HbyS/61Oacf0CPSeYqG12RO7VRALy/nC3Z9
 NNWNs2vwhpZUfHjbiS/zWL1BQ5WRZTcLc6qw/G7ZtK+zhxa9HbN4sI9LJs7cIBj2q9SjOqNr
 je2W1RTzxz0gnivxeS2hpJLNu6HsXVX9C5T0ckQ0bCAgCNLjWGHt/x3SnfPVeN7nNGPNNYtJ
 xX/R+2OA+5UVhPM8CkHYJ/2oeRKLUvx2ljebnP/MGBvLvaMojAlHPe5IGMDEwFTX0KKWTcW+
 eHIOv7zGMBaHl8zVq46ltr0lQzr4RDxZ96er2OTf4EMIx+zmGSbAyfwlfQwa9odMgnOwyDS1
 gCdR38lSRrl/ecIHC3yrfnc9e+BSrImdmIDRjmzxejtb0HyoDH8qbKspc7VJ1gxokuupvX7D
 QiUptmhWMA6cKFi6NYiTOk7lvNitrMCZdZyl2xZIZkCVHzzYpsIH5VM9ZAnWnFlrlOBhTaLZ
 w==
IronPort-HdrOrdr: A9a23:0csDT6goSVNk4lH+bnY0oOiO7nBQXv8ji2hC6mlwRA09TyVXra
 +TddAgpHrJYVEqKRUdcLG7Scu9qBznn6KdjbN9AV7mZniAhILKFvAA0WKB+Vzd8kTFn4Y36U
 4jSchD4bbLY2SS4/yX3CCIV/493diK972pj+/Cw3oocRtncMhbnmFE4sLxKDwPeOGAbqBJba
 ah2g==
X-Talos-CUID: 9a23:kBKai2MKYlm/yu5DB3lb+nAlOsYeL3iBzmzuOU/pJk1vV+jA
X-Talos-MUID: =?us-ascii?q?9a23=3A1Us3NQ2+B/RAnJiAY8GeiRLy2zUj84LxDEUii7U?=
 =?us-ascii?q?6ieLDZHJBBgyhhTiKXdpy?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.10,155,1719878400"; 
   d="scan'208";a="266074485"
Received: from rcdn-core-8.cisco.com ([173.37.93.144])
  by rcdn-iport-7.cisco.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Sep 2024 11:01:58 +0000
Received: from localhost ([10.239.201.197])
	(authenticated bits=0)
	by rcdn-core-8.cisco.com (8.15.2/8.15.2) with ESMTPSA id 48QB1tLF031588
	(version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
	Thu, 26 Sep 2024 11:01:57 GMT
Date: Thu, 26 Sep 2024 14:01:51 +0300
To: Gao Xiang <hsiangkao@linux.alibaba.com>
Subject: Re: [RFC PATCH 03/24] erofs: add Errno in Rust
Message-ID: <20240926110151.52cuuidfpjtgwnjd@amiculas-l-PF3FCGJH>
References: <239b5d1d-64a7-4620-9075-dc645d2bab74@proton.me>
 <20240925154831.6fe4ig4dny2h7lpw@amiculas-l-PF3FCGJH>
 <80cd0899-f14c-42f4-a0aa-3b8fa3717443@linux.alibaba.com>
 <20240925214518.fvig2n6cop3sliqy@amiculas-l-PF3FCGJH>
 <be7a42b2-ae52-4d51-9b0c-ed0304db3bdf@linux.alibaba.com>
 <0ca4a948-589a-4e2c-9269-827efb3fb9ef@linux.alibaba.com>
 <20240926081007.6amk4xfuo6l4jhsc@amiculas-l-PF3FCGJH>
 <54bf7cc6-a62a-44e9-9ff0-ca2e334d364f@linux.alibaba.com>
 <20240926095140.fej2mys5dee4aar2@amiculas-l-PF3FCGJH>
 <5f5e006b-d13b-45a5-835d-57a64d450a1a@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5f5e006b-d13b-45a5-835d-57a64d450a1a@linux.alibaba.com>
X-Authenticated-User: amiculas@cisco.com
X-Outbound-SMTP-Client: 10.239.201.197, [10.239.201.197]
X-Outbound-Node: rcdn-core-8.cisco.com
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
From: Ariel Miculas via Linux-erofs <linux-erofs@lists.ozlabs.org>
Reply-To: Ariel Miculas <amiculas@cisco.com>
Cc: Benno Lossin <benno.lossin@proton.me>, rust-for-linux@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, LKML <linux-kernel@vger.kernel.org>, Linus Torvalds <torvalds@linux-foundation.org>, Al Viro <viro@zeniv.linux.org.uk>, Gary Guo <gary@garyguo.net>, linux-fsdevel@vger.kernel.org, linux-erofs@lists.ozlabs.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On 24/09/26 06:46, Gao Xiang wrote:
> 
> 
> On 2024/9/26 17:51, Ariel Miculas wrote:
> > On 24/09/26 04:25, Gao Xiang wrote:
> > > 
> > > 
> > > On 2024/9/26 16:10, Ariel Miculas wrote:
> > > > On 24/09/26 09:04, Gao Xiang wrote:
> > > > > 
> > > 
> > > 
> > > ...
> > > 
> > > > 
> > > > And here [4] you can see the space savings achieved by PuzzleFS. In
> > > > short, if you take 10 versions of Ubuntu Jammy from dockerhub, they take
> > > > up 282 MB. Convert them to PuzzleFS and they only take up 130 MB (this
> > > > is before applying any compression, the space savings are only due to
> > > > the chunking algorithm). If we enable compression (PuzzleFS uses Zstd
> > > > seekable compression), which is a fairer comparison (considering that
> > > > the OCI image uses gzip compression), then we get down to 53 MB for
> > > > storing all 10 Ubuntu Jammy versions using PuzzleFS.
> > > > 
> > > > Here's a summary:
> > > > # Steps
> > > > 
> > > > * I’ve downloaded 10 versions of Jammy from hub.docker.com
> > > > * These images only have one layer which is in tar.gz format
> > > > * I’ve built 10 equivalent puzzlefs images
> > > > * Compute the tarball_total_size by summing the sizes of every Jammy
> > > >     tarball (uncompressed) => 766 MB (use this as baseline)
> > > > * Sum the sizes of every oci/puzzlefs image => total_size
> > > > * Compute the total size as if all the versions were stored in a single
> > > >     oci/puzzlefs repository => total_unified_size
> > > > * Saved space = tarball_total_size - total_unified_size
> > > > 
> > > > # Results
> > > > (See [5] if you prefer the video format)
> > > > 
> > > > | Type | Total size (MB) | Average layer size (MB) | Unified size (MB) | Saved (MB) / 766 MB |
> > > > | --- | --- | --- | --- | --- |
> > > > | Oci (uncompressed) | 766 | 77 | 766 | 0 (0%) |
> > > > | PuzzleFS uncompressed | 748 | 74 | 130 | 635 (83%) |
> > > > | Oci (compressed) | 282 | 28 | 282 | 484 (63%) |
> > > > | PuzzleFS (compressed) | 298 | 30 | 53 | 713 (93%) |
> > > > 
> > > > Here's the script I used to download the Ubuntu Jammy versions and
> > > > generate the PuzzleFS images [6] to get an idea about how I got to these
> > > > results.
> > > > 
> > > > Can we achieve these results with the current erofs features?  I'm
> > > > referring specifically to this comment: "EROFS already supports
> > > > variable-sized chunks + CDC" [7].
> > > 
> > > Please see
> > > https://erofs.docs.kernel.org/en/latest/comparsion/dedupe.html
> > 
> > Great, I see you've used the same example as I did. Though I must admit
> > I'm a little surprised there's no mention of PuzzleFS in your document.
> 
> Why I need to mention and even try PuzzleFS here (there are too many
> attempts why I need to try them all)?  It just compares to the EROFS
> prior work.
> 
> > 
> > > 
> > > 	                Total Size (MiB)	Average layer size (MiB)	Saved / 766.1MiB
> > > Compressed OCI (tar.gz)	282.5	28.3	63%
> > > Uncompressed OCI (tar)	766.1	76.6	0%
> > > Uncomprssed EROFS	109.5	11.0	86%
> > > EROFS (DEFLATE,9,32k)	46.4	4.6	94%
> > > EROFS (LZ4HC,12,64k)	54.2	5.4	93%
> > > 
> > > I don't know which compression algorithm are you using (maybe Zstd?),
> > > but from the result is
> > >    EROFS (LZ4HC,12,64k)  54.2
> > >    PuzzleFS compressed   53?
> > >    EROFS (DEFLATE,9,32k) 46.4
> > > 
> > > I could reran with EROFS + Zstd, but it should be smaller. This feature
> > > has been supported since Linux 6.1, thanks.
> > 
> > The average layer size is very impressive for EROFS, great work.
> > However, if we multiply the average layer size by 10, we get the total
> > size (5.4 MiB * 10 ~ 54.2 MiB), whereas for PuzzleFS, we see that while
> > the average layer size is 30 MIB (for the compressed case), the unified
> > size is only 53 MiB. So this tells me there's blob sharing between the
> > different versions of Ubuntu Jammy with PuzzleFS, but there's no sharing
> > with EROFS (what I'm talking about is deduplication across the multiple
> > versions of Ubuntu Jammy and not within one single version).
> 
> Don't make me wrong, I don't think you got the point.
> 
> First, what you asked was `I'm referring specifically to this
> comment: "EROFS already supports variable-sized chunks + CDC"`,
> so I clearly answered with the result of compressed data global
> deduplication with CDC.
> 
> Here both EROFS and Squashfs compresses 10 Ubuntu images into
> one image for fair comparsion to show the benefit of CDC, so

It might be a fair comparison, but that's not how container images are
distributed. You're trying to argue that I should just use EROFS and I'm
showing you that EROFS doesn't currently support the functionality
provided by PuzzleFS: the deduplication across multiple images.

> I believe they basically equal to your `Unified size`s, so
> the result is
> 
> 			Your unified size
> 	EROFS (LZ4HC,12,64k)  54.2
> 	PuzzleFS compressed   53?
> 	EROFS (DEFLATE,9,32k) 46.4
> 
> That is why I used your 53 unified size to show EROFS is much
> smaller than PuzzleFS.
> 
> The reason why EROFS and SquashFS doesn't have the `Total Size`s
> is just because we cannot store every individual chunk into some
> seperate file.

Well storing individual chunks into separate files is the entire point
of PuzzleFS.

> 
> Currently, I have seen no reason to open arbitary kernel files
> (maybe hundreds due to large folio feature at once) in the page
> fault context.  If I modified `mkfs.erofs` tool, I could give
> some similar numbers, but I don't want to waste time now due
> to `open arbitary kernel files in the page fault context`.
> 
> As I said, if PuzzleFS finally upstream some work to open kernel
> files in page fault context, I will definitely work out the same
> feature for EROFS soon, but currently I don't do that just
> because it's very controversal and no in-tree kernel filesystem
> does that.

The PuzzleFS kernel filesystem driver is still in an early POC stage, so
there's still a lot more work to be done.

Regards,
Ariel

> 
> Thanks,
> Gao Xiang
