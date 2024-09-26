Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 49AFA9870C1
	for <lists+linux-erofs@lfdr.de>; Thu, 26 Sep 2024 11:53:16 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lists.ozlabs.org;
	s=201707; t=1727344394;
	bh=ZGKzS95sQGD97oxxt1DK7jeDzl9OHurCeUjrLdIcwjk=;
	h=Date:To:Subject:References:In-Reply-To:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:Cc:
	 From;
	b=Cj2lIv1N3IByZFxWu/SAuGjy7pTMApUGkz2XH2AKjEeHyQrB/iDuJxZvPwOAy75N2
	 0o4didJNZzHSeN3lQ6eo8OgCIppoDrs3081HiwFohttUZQFCkZkXHmRf4KfFF3YJul
	 eTbnCvifkcmQC1oJTe/s6mKH1tpYAEp87kQyyH3G771w2hBn/dxY3fos/zJWSypvm8
	 rJ4ACxBeP3WdyBtPFUriSox9QIFj1zYFYkF0UnQ5QZrZJ91jZpo3+mqKByB/tuke2F
	 he6+DdY0jINCYyxWU+xUsZG6SvxrOl/VAlg7Jjdvyj7gWdx+aIGATAtGbw8jCWyZsM
	 DYw4fp+VxVODg==
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4XDpnQ1YqGz2ytN
	for <lists+linux-erofs@lfdr.de>; Thu, 26 Sep 2024 19:53:14 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=173.37.86.73
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1727344391;
	cv=none; b=FPTSAJWIXGKT1xcQY6KWPnh22MNFB0/bDFIcWnn/A/1JU+SylCznJFrOWDkrqZLrL3zhJcBw/SMJAd5kPy6opn4dJHKRTRTGKCUzrrbZjbHoX1AdM01Yb8b0GPwiovfZPnIPOBxRkTVLtqFgylALjdYqMwgBIQMl9ApZEzZ04i0ZAv6WaAkIHqZDZQAp8nuxII+NUR69pmZL1oVcyP+zmqtBDjujCU5vbycmhJBPaJAZmSEhUvaHXfVrSnHyvXxa7CxpEd2GJpK39jqes7nNmaonrX2H6eS+eylYqRJ7KT6SMXcaxc5nXUQsr5oPCZJRnzP5cfio2IxuXRfYuvujXw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1727344391; c=relaxed/relaxed;
	bh=ZGKzS95sQGD97oxxt1DK7jeDzl9OHurCeUjrLdIcwjk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nqvZ5tVmBe4/0cySWbGfe87b8i+IkCrybHTdb77dhM5xTXY42bz0X1FiawdASqydfB2nzrKEN5WShT+YrRxNk0ex4Z1EZ0WPjHpo3wUQrMX1hs6ECLHCKiLtGMS6QMk6ZfmtnX+R1N0R/Y87uvCanMwTj3UeZ2pIGMWMM+mzAvBvJ0x10ZD/6/2N2BOHXMvgm7p2Ser+9r1vr4B/DQVSuRS+n4f1PUNzdBCsACBhcUBQ+T/fBv1wnsJyHGjXi4/4mOfpymn91zosn/kJmk4EI8dyd+MDT2DMSvhbGwws6s97+Pi4twbPBFwsru5BzV6lm3IpWfODVq3zLCmcfoKB/w==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=cisco.com; spf=pass (client-ip=173.37.86.73; helo=rcdn-iport-2.cisco.com; envelope-from=amiculas@cisco.com; receiver=lists.ozlabs.org) smtp.mailfrom=cisco.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=cisco.com
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=cisco.com (client-ip=173.37.86.73; helo=rcdn-iport-2.cisco.com; envelope-from=amiculas@cisco.com; receiver=lists.ozlabs.org)
Received: from rcdn-iport-2.cisco.com (rcdn-iport-2.cisco.com [173.37.86.73])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4XDpnD3D0vz2yVd
	for <linux-erofs@lists.ozlabs.org>; Thu, 26 Sep 2024 19:52:56 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=cisco.com; i=@cisco.com; l=4212; q=dns/txt; s=iport;
  t=1727344384; x=1728553984;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=ZGKzS95sQGD97oxxt1DK7jeDzl9OHurCeUjrLdIcwjk=;
  b=d4uIbWOeRLcaEGFDSGVM9snASmSidF628Mx6bO9+nekFH+WgLrIHhbd6
   GHNq4gDyiV+erxtsIdvTtTFo6+jOiqm0/xpOl5XNzG56IkG4u7H4sQeH4
   1MCbYj8mAlR1d83cC1YTSmIB3QtQP7FkPLTjjzb+u2dzRzQpZlYqVBSZC
   E=;
X-CSE-ConnectionGUID: 5MVxrBN4TpqSeUy+2OSGwA==
X-CSE-MsgGUID: d05BKP/fRky454U9mGi/DQ==
X-IPAS-Result: =?us-ascii?q?A0AJAADiLfVmmJldJa1aHAEBAQEBAQcBARIBAQQEAQFAg?=
 =?us-ascii?q?TsHAQELAYNAWUNIhFWIHYcwgiIDnhWBfg8BAQENAQE5CwQBAYFyAYJORgKKB?=
 =?us-ascii?q?QImNAkOAQIEAQEBAQMCAwEBAQEBAQEBAQUBAQUBAQECAQcFFAEBAQEBAQEBN?=
 =?us-ascii?q?wUOO4V1DYZbAQEBAQIBIw8BRhALDgoCAiYCAlYGgxQBgkEjAxEGrxYaN3qBM?=
 =?us-ascii?q?oEB3jKBbIEaLgGISgGFZhuEXCcbgUlEhD8+gig5AQKFOoJpBIoIP4FMgiRSg?=
 =?us-ascii?q?nEPgyaDekQMMgOCTWYWJU1VhxcncIQXjGdSe3ghAhEBVRMXCwkFiTgKgxwpg?=
 =?us-ascii?q?UUmgQqDC4Ezg3KBZwlhiEmBDYE+gVkBgzdKg0+BeQU4Cj+CUWtOOQINAjeCK?=
 =?us-ascii?q?IEOglqFAFMdQAMLbT01FBusO4FbSIJBBz0kAlUCBXaBTS+WBo5ioQOEIowWl?=
 =?us-ascii?q?SZNEwODb40BhkSSe5g4Po17mngCBAYFAheBZzqBWzMaCBsVgyIJSRkPileDV?=
 =?us-ascii?q?g0Jg1iFFLlPQzICATgCBwEKAQEDCY1SAQE?=
IronPort-Data: A9a23:5n0Iaq0F2VaOx42Z0/bD5d12kn2cJEfYwER7XKvMYLTBsI5bpzAAz
 GJKXmHVOP6DamTxe4sna4ripk9XucfRnIBrTVY93Hw8FHgiRegpqji6wuYcGwvIc6UvmWo+t
 512huHodZ1yEzmG4E/0YtANlFEkvYmQXL3wFeXYDS54QA5gWU8JhAlq8wIDqtYAbeORXUXU4
 bsen+WFYAX5g28ubDpPg06+gEoHUMra6WtwUmMWPZinjHeG/1EJAZQWI72GLneQauF8Au6gS
 u/f+6qy92Xf8g1FIovNfmHTKxBirhb6ZGBiu1IOM0SQqkEqSh8ajs7XAMEhhXJ/0F1lqTzeJ
 OJl7vRcQS9xVkHFdX90vxNwS0mSNoUekFPLzOTWXcG7lyX7n3XQL/pGUWQILZcy3LpLGXh1+
 MEJa2oqVT+crrfjqF67YrEEasULNsLnOsYUvWttiGufBvc9SpeFSKLPjTNa9G5v3YYVQrCPP
 IxANGEHgBfoO3WjPn8eDZM1geOhnVH0ciZTrxSeoq9fD237llEriem8aIeFEjCMbckNw2y7n
 iXIxWfoXkxGCY2a5jvC3kv504cjmgugBdpNT+fnnhJwu3WXx2oOGFgbT1y1utG9i1WiQJRYO
 Ugd8DFoqrI9nGSvT9/gT1i2u3KJoBMYc8RfHvd86wyXzKfQpQGDCQAsQTdbefQpvdUnSiEtk
 FmEg7vBGz11t5WHRHSc6PGQrDWvKW4SN2BEeCxsZRcC+cfqpI0ophbOSMtzVaCyk9v5EC3xx
 DbMqzIx750XjMgWx+C48ErBjjaEuJfEVEg26x/RU2bj6Rl2DKaqfYGn6ljz6fdGMZaXSUSHs
 HEYms+YqucUAvmljjGWXKADG6vs4/eDLS30n1FiBd8i+i6r9nrleppfiBl0KUFvNYAAfiTyY
 Un7oRlW+JhVen6nBYd3eIO4DcspxK/IEdXjS+CSZ95PaJF7fUmM+yQGWKKL93rmnE5pmqYlN
 NLBN82tFn0dT69gyVJaWtvxz5d24x4u30n1Gazj1i+q7KvdPlmuZqgsZQ7mgv8C0IuIpwDc8
 tB6PsSMyglCXOCWXsUx2dBPRbztBSZnba0au/Bqmvi/zh2K8VzN5tfLyr8nPodihakQzKHD/
 2q2XQlTz1+XaZz7xeeiNCwLhFDHBMoXQZcH0coEZgjAN58LOt3H0UvnX8FrFYTLDcQ6pRKOc
 9ELet+bHtNEQSnd9jIWYPHV9dM4K0771FvUb3L1MVDTmqKMoSSUpLcImSOypUEz4taf75dWT
 0CIj1mCGMFSHWyO8u6NMq31kztdQkTxaMopAhOXeYMMEKkd2INrMCf2xuQmON0BLA6Lxz2Rk
 W6r7eQw+4HwT3sO2ICR38is9t7xe8MnRxYyNzeAt96ea3KFlldPNKcdCo5kixiHCjOtkEhjD
 M0Ip8zB3AovxwoU7NUsSOc3nMrTJbLH/tdn8+itJ12TB3zDN1+qCiPuMRVn3kGV+oJkhA==
IronPort-HdrOrdr: A9a23:SiGP06w4dc0tuBott7QZKrPwCb1zdoMgy1knxilNoNJuHfBws/
 re+cjzsiWE7Ar5OUtQ++xoV5PrfZqxz/NICMwqTNCftWrdyQiVxeNZjLcKqgeIc0bDH6xmtZ
 uIGJIRNDSfNzRHpPe/yBWkEtom3dmM+L2liKPj1Xt3JDsaDZ2JK2xCe36m+oocfng+OaYE
X-Talos-CUID: 9a23:VYFqjG9RK7w/J1N5/aaVvxMxJNA/WFuB8G/JGEKFGCUzb4a6VnbFrQ==
X-Talos-MUID: =?us-ascii?q?9a23=3APNWo/A9m1agCWxyO7MHQ6LeQf8swvo6NMAcDq5Y?=
 =?us-ascii?q?X55TYCH11FDbaoA3iFw=3D=3D?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.10,260,1719878400"; 
   d="scan'208";a="252199058"
Received: from rcdn-core-2.cisco.com ([173.37.93.153])
  by rcdn-iport-2.cisco.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Sep 2024 09:51:49 +0000
Received: from localhost ([10.239.201.197])
	(authenticated bits=0)
	by rcdn-core-2.cisco.com (8.15.2/8.15.2) with ESMTPSA id 48Q9pjEl021034
	(version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
	Thu, 26 Sep 2024 09:51:48 GMT
Date: Thu, 26 Sep 2024 12:51:40 +0300
To: Gao Xiang <hsiangkao@linux.alibaba.com>
Subject: Re: [RFC PATCH 03/24] erofs: add Errno in Rust
Message-ID: <20240926095140.fej2mys5dee4aar2@amiculas-l-PF3FCGJH>
References: <ac871d1e-9e4e-4d1b-82be-7ae87b78d33e@proton.me>
 <9bbbac63-c05f-4f7b-91c2-141a93783cd3@linux.alibaba.com>
 <239b5d1d-64a7-4620-9075-dc645d2bab74@proton.me>
 <20240925154831.6fe4ig4dny2h7lpw@amiculas-l-PF3FCGJH>
 <80cd0899-f14c-42f4-a0aa-3b8fa3717443@linux.alibaba.com>
 <20240925214518.fvig2n6cop3sliqy@amiculas-l-PF3FCGJH>
 <be7a42b2-ae52-4d51-9b0c-ed0304db3bdf@linux.alibaba.com>
 <0ca4a948-589a-4e2c-9269-827efb3fb9ef@linux.alibaba.com>
 <20240926081007.6amk4xfuo6l4jhsc@amiculas-l-PF3FCGJH>
 <54bf7cc6-a62a-44e9-9ff0-ca2e334d364f@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <54bf7cc6-a62a-44e9-9ff0-ca2e334d364f@linux.alibaba.com>
X-Authenticated-User: amiculas@cisco.com
X-Outbound-SMTP-Client: 10.239.201.197, [10.239.201.197]
X-Outbound-Node: rcdn-core-2.cisco.com
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
Cc: Gary Guo <gary@garyguo.net>, rust-for-linux@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-erofs@lists.ozlabs.org, LKML <linux-kernel@vger.kernel.org>, Al Viro <viro@zeniv.linux.org.uk>, Benno Lossin <benno.lossin@proton.me>, linux-fsdevel@vger.kernel.org, Linus Torvalds <torvalds@linux-foundation.org>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On 24/09/26 04:25, Gao Xiang wrote:
> 
> 
> On 2024/9/26 16:10, Ariel Miculas wrote:
> > On 24/09/26 09:04, Gao Xiang wrote:
> > > 
> 
> 
> ...
> 
> > 
> > And here [4] you can see the space savings achieved by PuzzleFS. In
> > short, if you take 10 versions of Ubuntu Jammy from dockerhub, they take
> > up 282 MB. Convert them to PuzzleFS and they only take up 130 MB (this
> > is before applying any compression, the space savings are only due to
> > the chunking algorithm). If we enable compression (PuzzleFS uses Zstd
> > seekable compression), which is a fairer comparison (considering that
> > the OCI image uses gzip compression), then we get down to 53 MB for
> > storing all 10 Ubuntu Jammy versions using PuzzleFS.
> > 
> > Here's a summary:
> > # Steps
> > 
> > * I’ve downloaded 10 versions of Jammy from hub.docker.com
> > * These images only have one layer which is in tar.gz format
> > * I’ve built 10 equivalent puzzlefs images
> > * Compute the tarball_total_size by summing the sizes of every Jammy
> >    tarball (uncompressed) => 766 MB (use this as baseline)
> > * Sum the sizes of every oci/puzzlefs image => total_size
> > * Compute the total size as if all the versions were stored in a single
> >    oci/puzzlefs repository => total_unified_size
> > * Saved space = tarball_total_size - total_unified_size
> > 
> > # Results
> > (See [5] if you prefer the video format)
> > 
> > | Type | Total size (MB) | Average layer size (MB) | Unified size (MB) | Saved (MB) / 766 MB |
> > | --- | --- | --- | --- | --- |
> > | Oci (uncompressed) | 766 | 77 | 766 | 0 (0%) |
> > | PuzzleFS uncompressed | 748 | 74 | 130 | 635 (83%) |
> > | Oci (compressed) | 282 | 28 | 282 | 484 (63%) |
> > | PuzzleFS (compressed) | 298 | 30 | 53 | 713 (93%) |
> > 
> > Here's the script I used to download the Ubuntu Jammy versions and
> > generate the PuzzleFS images [6] to get an idea about how I got to these
> > results.
> > 
> > Can we achieve these results with the current erofs features?  I'm
> > referring specifically to this comment: "EROFS already supports
> > variable-sized chunks + CDC" [7].
> 
> Please see
> https://erofs.docs.kernel.org/en/latest/comparsion/dedupe.html

Great, I see you've used the same example as I did. Though I must admit
I'm a little surprised there's no mention of PuzzleFS in your document.

> 
> 	                Total Size (MiB)	Average layer size (MiB)	Saved / 766.1MiB
> Compressed OCI (tar.gz)	282.5	28.3	63%
> Uncompressed OCI (tar)	766.1	76.6	0%
> Uncomprssed EROFS	109.5	11.0	86%
> EROFS (DEFLATE,9,32k)	46.4	4.6	94%
> EROFS (LZ4HC,12,64k)	54.2	5.4	93%
> 
> I don't know which compression algorithm are you using (maybe Zstd?),
> but from the result is
>   EROFS (LZ4HC,12,64k)  54.2
>   PuzzleFS compressed   53?
>   EROFS (DEFLATE,9,32k) 46.4
> 
> I could reran with EROFS + Zstd, but it should be smaller. This feature
> has been supported since Linux 6.1, thanks.

The average layer size is very impressive for EROFS, great work.
However, if we multiply the average layer size by 10, we get the total
size (5.4 MiB * 10 ~ 54.2 MiB), whereas for PuzzleFS, we see that while
the average layer size is 30 MIB (for the compressed case), the unified
size is only 53 MiB. So this tells me there's blob sharing between the
different versions of Ubuntu Jammy with PuzzleFS, but there's no sharing
with EROFS (what I'm talking about is deduplication across the multiple
versions of Ubuntu Jammy and not within one single version).

Of course, with only 10 images, the space savings don't seem that
impressive for PuzzleFS compared to EROFS, but imagine we are storing
hundreds/thousands of Ubuntu versions. Then we're also building OCI
images on top of these versions. So if the user already has all the
blobs for an Ubuntu version, then we only need to ship the chunks that
have changed / have been added as a result of the specific application
that we've built on top of an existing Ubuntu version.

One more thing: the "Unified size" column is the key for understanding
the space savings offered by PuzzleFS and I see that you've left this
column out of your table.

Regards,
Ariel

> 
> Thanks,
> Gao Xiang
