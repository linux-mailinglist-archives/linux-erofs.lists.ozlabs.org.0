Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id BB1D59873D9
	for <lists+linux-erofs@lfdr.de>; Thu, 26 Sep 2024 14:52:14 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lists.ozlabs.org;
	s=201707; t=1727355124;
	bh=13XC0SDx7lZbkZwxtT4I64b73mMeM0qQgCELOwdYjSo=;
	h=Date:To:Subject:References:In-Reply-To:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:Cc:
	 From;
	b=SLVOqe2Tqf1tv+jx3rkBxnQvTLsek25MJ7kB6HdaJktLihFOygQ7+h19xKWBMjL1o
	 tkt1CNlCbEdD8KEpqwzM4FS9bAkAV3PbPetwPb/LIwXeDzrrV0BfQFt4x0wR/obC1+
	 VUpeFdJeoVNhOyta7tjEjbZBMb2fZuMH0nmaGfMDO004wy5te5G6gAP2TMPgYM7eco
	 5UHDVnKyzbl0tEdWOUCTk8eM/u3akMv0Exbs03+tzZhFQpHX+PrtuB+/qeF0dQgbv7
	 jh+/CSRXsaF+M5xiQl65mxeF5OV0LczH23e0NatsUC5RIG3lD4rKCZKvWF3jC47gk5
	 YwCc0FiI7eQ5g==
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4XDtlm0TbYz2ym2
	for <lists+linux-erofs@lfdr.de>; Thu, 26 Sep 2024 22:52:04 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=173.37.86.73
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1727355121;
	cv=none; b=BW02NNf2vPKje7jPlTche8Sg5/YnAUQ186wqqDn3LSjy6kNHslNMX29nZWIJy1V848BPUjwfXl3YTyUMrS5mOzG990gUtS9GEU/8yjx59MUzSLcng8/Vz9vVQFqeZ0L8hestp31YMZnraKNul8k6YC9NzEfOTPS+xS0Iu0JyLR/JnURFzaSBDIIrXs1SJpzFqVMMH0apinQfU7nHF8Bv9SeFW3BvhsSwviCw7b4g/WJgTwVfujNOabKd/vGR5NsZRLV5v+LJhYSX11FM665oMxtgQKz5YO7ZgV8XOhZ2ugjWiK2khXfOuI4zfxijVin5uaTLY4JEKelr3jp0aPs8pg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1727355121; c=relaxed/relaxed;
	bh=13XC0SDx7lZbkZwxtT4I64b73mMeM0qQgCELOwdYjSo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=E80ZF1VDVAHLIQlZaJbD3vEOmBMwAHweEWB8Lhi3VpsDAbQqYISJe2b4wTuRctnkrinJuZnFNDZXGQk7EdIIqV9zU/n/9FpB24QcnDPnmsQ8dLVOvV6lBEOdBFqZ9FPGDQJQJ36scg9OUmFEjgL+gTWYJqZeKla+ECcJBPrWwfdwGIHaJFUbFebEEp6psp+kZwL8vW7idrS+PcZ6Y1hcCyYBx2XldVm61d2VHHyhiJcMUFWfhSRki1andPnoawibM9d09qEnPNmD0aDBL382mst0Rvab7LAWcotRbkk3wSxEn7IhjaF8Gy/+IB894nwuFRLlNYFu8ZMr+TUJpyWzQA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=cisco.com; spf=pass (client-ip=173.37.86.73; helo=rcdn-iport-2.cisco.com; envelope-from=amiculas@cisco.com; receiver=lists.ozlabs.org) smtp.mailfrom=cisco.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=cisco.com
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=cisco.com (client-ip=173.37.86.73; helo=rcdn-iport-2.cisco.com; envelope-from=amiculas@cisco.com; receiver=lists.ozlabs.org)
Received: from rcdn-iport-2.cisco.com (rcdn-iport-2.cisco.com [173.37.86.73])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4XDtlb3LYXz2yVT
	for <linux-erofs@lists.ozlabs.org>; Thu, 26 Sep 2024 22:51:48 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=cisco.com; i=@cisco.com; l=4726; q=dns/txt; s=iport;
  t=1727355115; x=1728564715;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=13XC0SDx7lZbkZwxtT4I64b73mMeM0qQgCELOwdYjSo=;
  b=i7dZe6ToUB5MPWtKaxi2yJQp1FBmv66Ao4J+o2A5fDXg2Do7kSEyPnZL
   w/FKLaXXohCtQFStSFU/G/n99ArKWqm10QC9BZW/wzwpqJnlxeb2aNjVv
   cjs2cCVXsPDAogpVZkr9JCvu9/Nfa8ne60AecjNpjSSswoiB+opw5n0t2
   U=;
X-CSE-ConnectionGUID: jd8hYSBIQWapzH8zNMkltg==
X-CSE-MsgGUID: 7LAFSQ8CTeiChYQd1EcnLg==
X-IPAS-Result: =?us-ascii?q?A0AJAABWV/VmmJNdJa1aGwEBAQEBAQEBBQEBARIBAQEDA?=
 =?us-ascii?q?wEBAUCBOwYBAQELAYNAWUNICYxphzCCIgOeFYF+DwEBAQ0BATsJBAEBhQcCi?=
 =?us-ascii?q?gUCJjQJDgECBAEBAQEDAgMBAQEBAQEBAQEFAQEFAQEBAgEHBRQBAQEBAQEBA?=
 =?us-ascii?q?TcFSYV1DYZbAQEBAQIBOjoFEAsOCi5WBoMUAYJBIwMRBq9+eIE0gQGDbEHaB?=
 =?us-ascii?q?YFmBoFIAYhKAYVmG4RcJxuBSUSEPz6CYQICgTaGbASOfHCEN4UGgQIDgRCBP?=
 =?us-ascii?q?WYWJU1ViC6QflJ7eCECEQFVExcLCQWJOAqDHCmBRSaBCoMLgTODcoFnCWGIS?=
 =?us-ascii?q?YENgT6BWQGDN0qDT4F5BTgKP4JRa045Ag0CN4IogQ6CWoUAUx1AAwttPTUUG?=
 =?us-ascii?q?6w7gVtIgkFoLQEHJAV2CgyBLDqWBo5in0WBPoQijBaVJk0TA4NvjQGGRJJ7m?=
 =?us-ascii?q?HaNe5VWhSICBAYFAheBZzqBWzMaCBsVgyNRGQ+OLQ0Jg1i+WUMyOwIHCwEBA?=
 =?us-ascii?q?wmLVoF8AQE?=
IronPort-Data: A9a23:6ebSZaDSyrwhbhVW/yHkw5YqxClBgxIJ4kV8jS/XYbTApD4hhTdSx
 2EXUDuEP6mOZmvyeo8iboSwp0wAv5LSnd5jOVdlrnsFo1CmBibm6XV1Cm+qYkt+++WaFBoPA
 /02M4SGcYZuCCeF9n9BC5C5xVFkz6aEW7HgP+DNPyF1VGdMRTwo4f5Zs7ZRbrVA357gWmthh
 fuo+5eDYA7/hWYoWo4pw/vrRC1H7ayaVAww5jTSVdgT1HfCmn8cCo4oJK3ZBxPQXolOE+emc
 P3Ixbe/83mx109F5gSNy+uTnuUiG9Y+DCDW4pZkc/HKbitq+kTe5p0G2M80Mi+7vdkmc+dZk
 72hvbToIesg0zaldO41C3G0GAkmVUFKFSOuzXWX6aSuI0P6n3TEwfk+DHANF6whxe9vE0Ee5
 9o9KzQRYUXW7w626OrTpuhEnM8vKozgO5kS/yg5izrYFv0hB5vERs0m5/cBg2x23Z8ITK2YP
 pZGAdZsREyojxlnM1IWA486lfyAjXjkeDoeo1WQzUYyyzKOllYuiuiyYbI5fPTVYex7pX/Ij
 V7L/k/5MygWbfGUzx6KpyfEaujnxn6jB9lIS9VU7MVChFyV23xWBQcRW0CTpfiillX4XMBbI
 kYPvC00osAa8E2tU8m4UQa0rWCJujYCVNdKVe438geAzuzT+QnxLmcNVC9pZ9U8pcArQnos2
 0Pht83oHztHorCTSGzb8raSsCP0PjIaa3IBDQcYShEb6t3vu6k3jxTSXpNtF7OzgtTpGDb2h
 TeQo0AWg7QVkN5O1Kih+13Dqyyjq4KPTQMv4AjTGGW/4WtRa5SoaI+owVza6+tQIoGESFWIo
 HkDnY6Z9u9mJYuQjzDITuIXWbWo4euVGCPTjEQpHJQ78TmpvXm5cuh46jx4IkAvNsEfYj7vS
 FfJvh9W4tlWMROCbbR2aoS+CM0t5azhE8n1EPnQb9BHaJE3fwiClByCfmaK1Gzr1UMri6x6Y
 M7dese3BnFcAqNipNarewsD+b0nliAP/knyfK/y1waHgai4QX2RVbhQZTNicdsFxK+DpQzU9
 fNWOM2L1whTXYXCjs//r9J7wbcicyRTOHzml/G7YNJvNeaPJY3MI+XazbVkcIt/kuEMz6HD/
 2q2XQlTz1+XaZz7xeeiNC4LhFDHBMoXQZcH0coEZgrAN58LOtrH0UvnX8FrFYTLDcQ6pRKOc
 9ELet+bHtNEQSnd9jIWYPHV9dM4K0771FvUb3L1MVDTmqKMoSSUpLcImSOypUEz4taf75dWT
 0CIj1mCGMFSHWyO8u6NMq31kztdQkTxaMopAhOXeYMMEKkd2INrMCf2xuQmON0BLA6Lxz2Rk
 W6r7eQw+4HwT3sO2ICR38is9t7xe8MnRxoyNzeAt96ea3KFlldPNKcdCo5kixiHCjOtkEhjD
 M0Ip8zB3AovwQ8R4tojQu0xpU/8jvO2z4JnIs1fNC2jRzyW5nlIexFqAeEnWnVx+4Jk
IronPort-HdrOrdr: A9a23:bmANwaBiEHGtGG3lHemd55DYdb4zR+YMi2TDtnoddfUxSKfzqy
 nApoV/6faKskd0ZJhCo7y90cu7MBHhHPdOiOEs1L6ZLW7bkWGjRbsD0WNFrgePJwTk+vdZxe
 N8dcFFeb7NJEJnhsX36hTQKbkd6cSAmZrIudvj
X-Talos-CUID: =?us-ascii?q?9a23=3AxAWj82sxdMMXsCVehTNpdpMM6Isnfi3d/Uz6Ana?=
 =?us-ascii?q?HAH57aO2Hb3qT/L9rxp8=3D?=
X-Talos-MUID: 9a23:4E292wqt3VbOusIoWYwez25GHelT2vSFNE0MupU3gsXdGCd2HzjI2Q==
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.11,155,1725321600"; 
   d="scan'208";a="252272879"
Received: from rcdn-core-11.cisco.com ([173.37.93.147])
  by rcdn-iport-2.cisco.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Sep 2024 12:50:40 +0000
Received: from localhost ([10.239.198.46])
	(authenticated bits=0)
	by rcdn-core-11.cisco.com (8.15.2/8.15.2) with ESMTPSA id 48QCobmw029017
	(version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
	Thu, 26 Sep 2024 12:50:39 GMT
Date: Thu, 26 Sep 2024 15:50:36 +0300
To: Gao Xiang <hsiangkao@linux.alibaba.com>
Subject: Re: [RFC PATCH 03/24] erofs: add Errno in Rust
Message-ID: <20240926124959.n7i33p4fonp2op27@amiculas-l-PF3FCGJH>
References: <80cd0899-f14c-42f4-a0aa-3b8fa3717443@linux.alibaba.com>
 <20240925214518.fvig2n6cop3sliqy@amiculas-l-PF3FCGJH>
 <be7a42b2-ae52-4d51-9b0c-ed0304db3bdf@linux.alibaba.com>
 <0ca4a948-589a-4e2c-9269-827efb3fb9ef@linux.alibaba.com>
 <20240926081007.6amk4xfuo6l4jhsc@amiculas-l-PF3FCGJH>
 <54bf7cc6-a62a-44e9-9ff0-ca2e334d364f@linux.alibaba.com>
 <20240926095140.fej2mys5dee4aar2@amiculas-l-PF3FCGJH>
 <5f5e006b-d13b-45a5-835d-57a64d450a1a@linux.alibaba.com>
 <20240926110151.52cuuidfpjtgwnjd@amiculas-l-PF3FCGJH>
 <ec17a30e-c63a-4615-8784-69aef2bb2bae@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ec17a30e-c63a-4615-8784-69aef2bb2bae@linux.alibaba.com>
X-Authenticated-User: amiculas@cisco.com
X-Outbound-SMTP-Client: 10.239.198.46, [10.239.198.46]
X-Outbound-Node: rcdn-core-11.cisco.com
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

On 24/09/26 07:23, Gao Xiang wrote:
> 
> 
> On 2024/9/26 19:01, Ariel Miculas via Linux-erofs wrote:
> > On 24/09/26 06:46, Gao Xiang wrote:
> 
> ...
> 
> > > 
> > > > 
> > > > > 
> > > > > 	                Total Size (MiB)	Average layer size (MiB)	Saved / 766.1MiB
> > > > > Compressed OCI (tar.gz)	282.5	28.3	63%
> > > > > Uncompressed OCI (tar)	766.1	76.6	0%
> > > > > Uncomprssed EROFS	109.5	11.0	86%
> > > > > EROFS (DEFLATE,9,32k)	46.4	4.6	94%
> > > > > EROFS (LZ4HC,12,64k)	54.2	5.4	93%
> > > > > 
> > > > > I don't know which compression algorithm are you using (maybe Zstd?),
> > > > > but from the result is
> > > > >     EROFS (LZ4HC,12,64k)  54.2
> > > > >     PuzzleFS compressed   53?
> > > > >     EROFS (DEFLATE,9,32k) 46.4
> > > > > 
> > > > > I could reran with EROFS + Zstd, but it should be smaller. This feature
> > > > > has been supported since Linux 6.1, thanks.
> > > > 
> > > > The average layer size is very impressive for EROFS, great work.
> > > > However, if we multiply the average layer size by 10, we get the total
> > > > size (5.4 MiB * 10 ~ 54.2 MiB), whereas for PuzzleFS, we see that while
> > > > the average layer size is 30 MIB (for the compressed case), the unified
> > > > size is only 53 MiB. So this tells me there's blob sharing between the
> > > > different versions of Ubuntu Jammy with PuzzleFS, but there's no sharing
> > > > with EROFS (what I'm talking about is deduplication across the multiple
> > > > versions of Ubuntu Jammy and not within one single version).
> > > 
> > > Don't make me wrong, I don't think you got the point.
> > > 
> > > First, what you asked was `I'm referring specifically to this
> > > comment: "EROFS already supports variable-sized chunks + CDC"`,
> > > so I clearly answered with the result of compressed data global
> > > deduplication with CDC.
> > > 
> > > Here both EROFS and Squashfs compresses 10 Ubuntu images into
> > > one image for fair comparsion to show the benefit of CDC, so
> > 
> > It might be a fair comparison, but that's not how container images are
> > distributed. You're trying to argue that I should just use EROFS and I'm
> 
> First, OCI layer is just distributed like what I said.
> 
> For example, I could introduce some common blobs to keep
> chunks as chunk dictionary.   And then the each image
> will be just some index, and all data will be
> deduplicated.  That is also what Nydus works.

I don't really follow what Nydus does. Here [1] it says they're using
fixed size chunks of 1 MB. Where is the CDC step exactly?

[1] https://github.com/dragonflyoss/nydus/blob/master/docs/nydus-design.md#2-rafs

> 
> > showing you that EROFS doesn't currently support the functionality
> > provided by PuzzleFS: the deduplication across multiple images.
> 
> No, EROFS supports external devices/blobs to keep a lot of
> chunks too (as dictionary to share data among images), but
> clearly it has the upper limit.
> 
> But PuzzleFS just treat each individual chunk as a seperate
> file, that will cause unavoidable "open arbitary number of
> files on reading, even in page fault context".
> 
> > 
> > > I believe they basically equal to your `Unified size`s, so
> > > the result is
> > > 
> > > 			Your unified size
> > > 	EROFS (LZ4HC,12,64k)  54.2
> > > 	PuzzleFS compressed   53?
> > > 	EROFS (DEFLATE,9,32k) 46.4
> > > 
> > > That is why I used your 53 unified size to show EROFS is much
> > > smaller than PuzzleFS.
> > > 
> > > The reason why EROFS and SquashFS doesn't have the `Total Size`s
> > > is just because we cannot store every individual chunk into some
> > > seperate file.
> > 
> > Well storing individual chunks into separate files is the entire point
> > of PuzzleFS.
> > 
> > > 
> > > Currently, I have seen no reason to open arbitary kernel files
> > > (maybe hundreds due to large folio feature at once) in the page
> > > fault context.  If I modified `mkfs.erofs` tool, I could give
> > > some similar numbers, but I don't want to waste time now due
> > > to `open arbitary kernel files in the page fault context`.
> > > 
> > > As I said, if PuzzleFS finally upstream some work to open kernel
> > > files in page fault context, I will definitely work out the same
> > > feature for EROFS soon, but currently I don't do that just
> > > because it's very controversal and no in-tree kernel filesystem
> > > does that.
> > 
> > The PuzzleFS kernel filesystem driver is still in an early POC stage, so
> > there's still a lot more work to be done.
> 
> I suggest that you could just ask FS/MM folks about this ("open
> kernel files when reading in the page fault") first.
> 
> If they say "no", I suggest please don't waste on this anymore.
> 
> Thanks,
> Gao Xiang
