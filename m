Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id CE518986E8F
	for <lists+linux-erofs@lfdr.de>; Thu, 26 Sep 2024 10:11:41 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lists.ozlabs.org;
	s=201707; t=1727338295;
	bh=4GVN0gKJHjMpXBaU95/Vf+sjIiBNif/SvQEYF08IIqE=;
	h=Date:To:Subject:References:In-Reply-To:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:Cc:
	 From;
	b=fPOjATgOrW7EIarrjZ7vu/GaTpEbU3mXQds51ZWuLB6dxLo4d6HF9eF2RWnHsT5mq
	 C5nw3U4nJFr0D/7sIvJ707SMG2b/4lw+Aoto4MVrV4soE6x571Q6b8e7LccRLLf886
	 EdS/OuDi+PY6XvMZv7Wm6F0x/nY8r6iM95eAAh50LlebDudXxDyhKeWyqWaHwmCatb
	 6FpWXRveOFvA9AqymfaCyJSHm3odbdzUJB4u3LLfsV3kGiE5Z8fvk3jNZHSaklYp59
	 kaCLISLjQbheJVsiKPgedq9tjquqAEIbGsmwq2vpNjl3NcyRtqeCtGW41UaZ1EX3hx
	 edQUy5MdPqNbA==
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4XDmX73mfcz2ysh
	for <lists+linux-erofs@lfdr.de>; Thu, 26 Sep 2024 18:11:35 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=173.37.86.76
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1727338291;
	cv=none; b=d0gfmGxBFRzFbASA2J8fqGVqqnJW975ECTcqKILqya2bN6eM1t2JP13UGRMm/ZXyR+NJOUoqudqrloKk/5czndEmyyCU/VusXL7FxzPJCftPyzfKq54wiJGRFOd0R6SN9ESncP8NenPMg2NzY6mkYba/CkqDIQAsrVUg6ZvZbeDtbvHZ0yOtr9eBS4IKEZJSZ3t9YBqrM+0YxGMcp5xIZReyISaRZfYzhKlyfr+A4XkTojyAX+6oloTi+5FugyXJ2/dU14LSIv5HcHHzyw5g3BdksXK2u29EVQL3WoPZ4GwZfbBt0MXPOEuSorVNQrcB0zA60ckGPkWJBrfSLOf7cw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1727338291; c=relaxed/relaxed;
	bh=4GVN0gKJHjMpXBaU95/Vf+sjIiBNif/SvQEYF08IIqE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fuSmNZGyl25Bk6V8Rj1ZzhVdny8BN3fL0wpWkkTytm8ivJWncPRB59kJLslSIxJ9COOX3qYTFiNGzu79iBvL5dIx65ldDWn7kMNCVD06mbUp1MianaASZ7l71nwgtMLdqmahgARCKtoUlUEVyAhW5WxLrpLDZmMNQcqg0tUJPjevWLsYWE7J/ZSRTDJv0gTq1N/Qg2KmxuIpR0jtoDwT+ESUDi2WJjno4jlpG9DFgCH0lGFDiJOcFwsQlYWfpLCCUlEt+2D+q/vapwzjEAxYfZrQJ+2jpgjpct8qxRvsRTVduP5mPz9H81H/Vde0nH+jka7/yj14nl7kUjQyIyj3BA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=cisco.com; dkim=pass (1024-bit key; unprotected) header.d=cisco.com header.i=@cisco.com header.a=rsa-sha256 header.s=iport header.b=Hhzynp2T; dkim-atps=neutral; spf=pass (client-ip=173.37.86.76; helo=rcdn-iport-5.cisco.com; envelope-from=amiculas@cisco.com; receiver=lists.ozlabs.org) smtp.mailfrom=cisco.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=cisco.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=cisco.com header.i=@cisco.com header.a=rsa-sha256 header.s=iport header.b=Hhzynp2T;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=cisco.com (client-ip=173.37.86.76; helo=rcdn-iport-5.cisco.com; envelope-from=amiculas@cisco.com; receiver=lists.ozlabs.org)
Received: from rcdn-iport-5.cisco.com (rcdn-iport-5.cisco.com [173.37.86.76])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4XDmWz0S3gz2xHg
	for <linux-erofs@lists.ozlabs.org>; Thu, 26 Sep 2024 18:11:19 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=cisco.com; i=@cisco.com; l=4379; q=dns/txt; s=iport;
  t=1727338287; x=1728547887;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=4GVN0gKJHjMpXBaU95/Vf+sjIiBNif/SvQEYF08IIqE=;
  b=Hhzynp2TkgSrAkKhRLXTTGL1vajDeSH13HmZ/qsaVlClIvXgMGqdNtpE
   qjwkDkqHqGXp/usEIhfSjfnDV6MY09sq0yYCRFnpM8cbAZe/orJ/8qZGu
   tEwO0i8j17jzqWK/AOjfUHqUTv+MXdjc7j8H27v/KUwcVgAhoLRccHY1B
   w=;
X-CSE-ConnectionGUID: ErvoNYTnRBieTXVxEl/auA==
X-CSE-MsgGUID: wOPktk49QyO1vGznmr3GRg==
X-IPAS-Result: =?us-ascii?q?A0AiAQAYFvVmmJNdJa1aHgEBCxIMQIFEC4IcgSVZQ0iEV?=
 =?us-ascii?q?Y9NgiIDnhWBfg8BAQENAQE9BwQBAYFyAYMUAooFAiY2Bw4BAgQBAQEBAwIDA?=
 =?us-ascii?q?QEBAQEBAQEBBQEBBQEBAQIBBwUUAQEBAQEBAQE3BUmFdQ2GXAEBAQMjDwFGE?=
 =?us-ascii?q?AsOCgICJgICVgYTgilYAYJkAxGvKRo3eoEygQGDbAMYJtoFgWyBGi6ISwGFZ?=
 =?us-ascii?q?huEXCcbgUlEhD8+gig5AQECGIUhgmkEikeFJYIdgg+FEUSDdBYlTVWHPnCQf?=
 =?us-ascii?q?lJ7eCECEQFVExcLCQWJOAqDHCmBRSaBCoMLgTODcoFnCWGISYENgT6BWQGDN?=
 =?us-ascii?q?0qDT4F5BTgKP4JRa045Ag0CN4IogQ6CWoUAUx1AAwttPTUUG6w6AYFbSIMFJ?=
 =?us-ascii?q?EkQBR1vSU0UDZNOgmeOYp9FgT6EIowWlSZNEwODb4FWkW86kkGYOD6Ne5VWJ?=
 =?us-ascii?q?IR+AgQGBQIXgW4EL4FbMxoIGxWCbgEzCQoMMxkPileDY4JDgR6CZIIwgQG4U?=
 =?us-ascii?q?UMyCzACBwEKAQEDCY1SAQE?=
IronPort-Data: A9a23:14TIw6oeKT8kBjYR1Hz/Ck5kUl9eBmI9YhIvgKrLsJaIsI4StFCzt
 garIBmAMv/YZmbxLYx3PNuz/UwEupPcnNBlHgNoqCsyRHgRpePIVI+TRqvS04x+DSFioGZPt
 Zh2hgzodZhsJpPkjk7wdOWn9z8kjPHgqoPUUIbsIjp2SRJvVBAvgBdin/9RqoNziLBVOSvV0
 T/Ji5OZYQfNNwJcaDpOt/rS8k035pwehRtB1rAATaET1LPhvyF94KI3fcmZM3b+S49IKe+2L
 86r5K255G7Q4yA2AdqjlLvhGmVSKlIFFVHT4pb+c/HKbilq/kTe4I5iXBYvQRs/ZwGyojxE4
 I4lWapc5useFvakdOw1C3G0GszlVEFM0OevzXOX6aR/w6BaGpfh660GMa04AWEX0sttH2Zox
 MAeEhoMYyyzufKbxPWyV8A506zPLOGzVG8ekmtrwTecBvE8TNWaGuPB5MRT23E7gcUm8fT2P
 pVCL2EwKkWbJUQTZT/7C7pm9AusrnD6cjZFrFuOjaE2+GPUigd21dABNfKPJILXFZQOwhzwS
 mTu4EPBAQ0ZaI2m2B3c7F2+gOrVxgzBV9dHfFG/3qU32ALInDN75ActfUe8u+ewjkKlc9ZeL
 VEEvyQpsK4+/VCqSd+7WAe3yFaAvxgBS59dCeo08ymJy7HI+ECeFGwNRCUHb8Yp3OcyRDo3x
 hqHhN/kGzFrmKOaRGjb9bqOqz62fy8PIgcqey4eSiMX7t/ivsc3jxTSXpBkCqHzk96dMTXxx
 S2a6SsznbMeieYV2Kihu1PKmTShot7OVAFdzgrNU22m7it9ZYi4d4Kv9F7X5OpBK4DfSUOO1
 FAehtOCqe4JF9SJlSqQUM0TE7yzofWIKjvRhRhoBZZJ3yiq/HqmdIZIyC16IV8vOc1sUTDge
 l77tgpL9ZBOOz2sYLMfS4i8DcIti6znDs/kUNjMdN1SZZ43cQLv1CF1ZEeW0GPkl2AokKciK
 dGSdcemBHwTT69gyVKLq/w1y7QnwGU1wnneAMmiiR+myrGZInWSTN/pLWdicMgU9r2DhjTp9
 ex1Nsa2+ytPfem5azT+pNt7wU8xEVA3ApX/qspyf+GFIxZ7FGxJNxM36e19E2CCt/oJ/tok7
 k2AtllkJE0TbEArxC2QYXxlLbjoR5s69Ct9Ni03NlHu0H8mCWpO0Ev9X8VpFVXE3LU/pRKRc
 xXjU57cahioYm+bkwnxlbGn8ORfmO2D3GpixRaNbjklZIJHTAfU4NLidQaH3HBRVHXt5Zpn+
 e34hlKzrX8/q+JKUZi+hBWHkgLZgJThsLguN6c1CoAJIRy3odICx9LZ1aVoeZ1kxer/Ksuyj
 FvOXkxC+oEhUqc+8cLCguifvpy1Hu5lVktcFC+z0FpFHXeyw4ZX+qcZCLzgVWmEDAvcofzyD
 c0LlKuUGKNcwz53X39UTuwDIVQWvYW//te3D21MQR32UrhcIuk/fSjYgpUR5vAlK30wkVLeZ
 39jM+JyYd2hUP4J2nZITOb5RoxvDc0ppwQ=
IronPort-HdrOrdr: A9a23:XZBeFK57WhAiRMF4YQPXwO3XdLJyesId70hD6qm+c3Nom+ij5q
 WTdZMgpHvJYVcqKRMdcL+7UpVoLUmwyXcx2/h3AV7AZniEhILLFuBfBOLZqlWKJ8S9zI5gPM
 xbHZSWZuedMXFKye7n/Qi1FMshytGb/K3tuf3T1B5WPGdXg2UK1XYANu5deXcGPTV7OQ==
X-Talos-CUID: =?us-ascii?q?9a23=3A6LHos2migOMJYd51TyZtM1M3gGDXOVDH0nD2EnO?=
 =?us-ascii?q?+M0xoRYGld0+9/ORtjuM7zg=3D=3D?=
X-Talos-MUID: =?us-ascii?q?9a23=3AUdI26AxoQGuqI6AM8jKjFKo7jDWaqLuJMEMRksl?=
 =?us-ascii?q?XgtijbDJfKTGYlm+YeIByfw=3D=3D?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.10,259,1719878400"; 
   d="scan'208";a="266589342"
Received: from rcdn-core-11.cisco.com ([173.37.93.147])
  by rcdn-iport-5.cisco.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Sep 2024 08:10:14 +0000
Received: from localhost ([10.239.201.197])
	(authenticated bits=0)
	by rcdn-core-11.cisco.com (8.15.2/8.15.2) with ESMTPSA id 48Q8AB1F023539
	(version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
	Thu, 26 Sep 2024 08:10:13 GMT
Date: Thu, 26 Sep 2024 11:10:07 +0300
To: Gao Xiang <hsiangkao@linux.alibaba.com>
Subject: Re: [RFC PATCH 03/24] erofs: add Errno in Rust
Message-ID: <20240926081007.6amk4xfuo6l4jhsc@amiculas-l-PF3FCGJH>
References: <20240916210111.502e7d6d.gary@garyguo.net>
 <2b04937c-1359-4771-86c6-bf5820550c92@linux.alibaba.com>
 <ac871d1e-9e4e-4d1b-82be-7ae87b78d33e@proton.me>
 <9bbbac63-c05f-4f7b-91c2-141a93783cd3@linux.alibaba.com>
 <239b5d1d-64a7-4620-9075-dc645d2bab74@proton.me>
 <20240925154831.6fe4ig4dny2h7lpw@amiculas-l-PF3FCGJH>
 <80cd0899-f14c-42f4-a0aa-3b8fa3717443@linux.alibaba.com>
 <20240925214518.fvig2n6cop3sliqy@amiculas-l-PF3FCGJH>
 <be7a42b2-ae52-4d51-9b0c-ed0304db3bdf@linux.alibaba.com>
 <0ca4a948-589a-4e2c-9269-827efb3fb9ef@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <0ca4a948-589a-4e2c-9269-827efb3fb9ef@linux.alibaba.com>
X-Authenticated-User: amiculas@cisco.com
X-Outbound-SMTP-Client: 10.239.201.197, [10.239.201.197]
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
Cc: Benno Lossin <benno.lossin@proton.me>, rust-for-linux@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, LKML <linux-kernel@vger.kernel.org>, Linus Torvalds <torvalds@linux-foundation.org>, Al Viro <viro@zeniv.linux.org.uk>, Gary Guo <gary@garyguo.net>, linux-fsdevel@vger.kernel.org, linux-erofs@lists.ozlabs.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On 24/09/26 09:04, Gao Xiang wrote:
> 
> 
> On 2024/9/26 08:40, Gao Xiang wrote:
> > 
> > 
> > On 2024/9/26 05:45, Ariel Miculas wrote:
> 
> ...
> 
> > > 
> > > I honestly don't see how it would look good if they're not using the
> > > existing filesystem abstractions. And I'm not convinced that Rust in the
> > > kernel would be useful in any way without the many subsystem
> > > abstractions which were implemented by the Rust for Linux team for the
> > > past few years.
> > 
> > So let's see the next version.
> 
> Some more words, regardless of in-tree "fs/xfs/libxfs",
> you also claimed "Another goal is to share the same code between user
> space and kernel space in order to provide one secure implementation."
> for example in [1].
> 
> I wonder Rust kernel VFS abstraction is forcely used in your userspace
> implementation, or (somewhat) your argument is still broken here.

Of course the implementations cannot be identical, but there is a lot of
shared code between the user space and kernel space PuzzleFS
implementations. The user space implementation uses the fuser [1] crate
and implicitly its API for implementing the read/seek/list_xattrs etc.
operations, while the kernel implementation uses the Rust filesystem
abstractions.

While it's currently not possible to use external crates in the Linux
kernel (maybe it won't ever be), one area for improvement would be to
keep the shared code between these PuzzleFS implementations in the
kernel and publish releases to crates.io from there. In this way it will
be obvious which parts of the code are shared and they will actually be
shared (right now the code is duplicated).

I've actually touched on these points [2] during my last year's
presentation of PuzzleFS at Open Source Summit Europe [3].

And here [4] you can see the space savings achieved by PuzzleFS. In
short, if you take 10 versions of Ubuntu Jammy from dockerhub, they take
up 282 MB. Convert them to PuzzleFS and they only take up 130 MB (this
is before applying any compression, the space savings are only due to
the chunking algorithm). If we enable compression (PuzzleFS uses Zstd
seekable compression), which is a fairer comparison (considering that
the OCI image uses gzip compression), then we get down to 53 MB for
storing all 10 Ubuntu Jammy versions using PuzzleFS.

Here's a summary:
# Steps

* I’ve downloaded 10 versions of Jammy from hub.docker.com
* These images only have one layer which is in tar.gz format
* I’ve built 10 equivalent puzzlefs images
* Compute the tarball_total_size by summing the sizes of every Jammy
  tarball (uncompressed) => 766 MB (use this as baseline)
* Sum the sizes of every oci/puzzlefs image => total_size
* Compute the total size as if all the versions were stored in a single
  oci/puzzlefs repository => total_unified_size
* Saved space = tarball_total_size - total_unified_size

# Results
(See [5] if you prefer the video format)

| Type | Total size (MB) | Average layer size (MB) | Unified size (MB) | Saved (MB) / 766 MB |
| --- | --- | --- | --- | --- |
| Oci (uncompressed) | 766 | 77 | 766 | 0 (0%) |
| PuzzleFS uncompressed | 748 | 74 | 130 | 635 (83%) |
| Oci (compressed) | 282 | 28 | 282 | 484 (63%) |
| PuzzleFS (compressed) | 298 | 30 | 53 | 713 (93%) |

Here's the script I used to download the Ubuntu Jammy versions and
generate the PuzzleFS images [6] to get an idea about how I got to these
results.

Can we achieve these results with the current erofs features?  I'm
referring specifically to this comment: "EROFS already supports
variable-sized chunks + CDC" [7].

[1] https://docs.rs/fuser/latest/fuser/
[2] https://youtu.be/OhMtoLrjiBY?si=iuk7PstznEUgnr4g&t=1150
[3] https://osseu2023.sched.com/event/1OGjk/puzzlefs-the-next-generation-container-filesystem-armand-ariel-miculas-cisco-systems
[4] https://youtu.be/OhMtoLrjiBY?si=jwReE1qjs1wXLUCr&t=1732
[5] https://youtu.be/OhMtoLrjiBY?si=Nhlz8FJ9CGnwgOlS&t=1862
[6] https://gist.github.com/ariel-miculas/956056f213db2d3027905c61264d160b
[7] https://github.com/project-machine/puzzlefs/issues/114#issuecomment-2367039464

Regards,
Ariel

> 
> [1] https://lore.kernel.org/r/20230609-feldversuch-fixieren-fa141a2d9694@brauner
> 
> Thanks,
> Gao Xiang
> 
> > 
> > Thanks,
> > Gao Xiang
> > 
> > > 
> > > Cheers,
> > > Ariel
> > > 
> 
