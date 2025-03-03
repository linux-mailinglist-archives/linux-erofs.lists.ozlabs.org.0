Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 72A5DA4BAA9
	for <lists+linux-erofs@lfdr.de>; Mon,  3 Mar 2025 10:20:31 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Z5tZh3Bbqz30W6
	for <lists+linux-erofs@lfdr.de>; Mon,  3 Mar 2025 20:20:28 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=83.149.199.84
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1740993626;
	cv=none; b=Zrc1S/rmOMhR4NQ7+zZIYnBnTi7lVhXvsVtXxKyHeooEQUgy21P3nuLcgnmosjaJAISNP9jFGOWs6yTq4VkXjhSV+ZSAorTVRs2fWiFnHLK4pnZPx1U8nQDC5IdCy9WgxqMOALkkzh+WNKSxpruAbX+YyGv59IbqYJrYHsN4WBkFYlM6l+ClZ47rCABkVJGiwXAS1wJVxlA/UbUui674vDHS8RSWEA2MoCrB2eWUOS/BwITzM6HWozoltH9go+So9me4LaiMcWltrtRNcsAd8AVRYDroSBIeUtQeJr8/C7K/vRjkfYstN44whQuAXWFJ7Fgoznbq5xa/y437YOvATw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1740993626; c=relaxed/relaxed;
	bh=yIKMCXjADGPI9vSNBDHS/nd+SYypPRjQI0Yuanov3Qo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HKlDv4h+++Ove6MYfqP6E++tZPKgb7Ra3avYNyn2nRMNhuQ6jtcH3MAGwZVJbljlUPj57ONSBxE0BW8IfsNx0yT4A+ONM3E9XZdgfZEVS6UCTZ8khhclG8XeBxX1j3mxZZaoRlRQCRECmxL/02KXZTRuJqIzwE02mB6UbNkqb0NhpQX9Rm09LQZkXruUZTTbwPSWSV0ES7Plc5y8zVOaMKfZnw0e1kf+ZLIR4N4viQM2bhu7Tef4HV0GbYNigHHXT6yYbt/rP3SpOh9QX5ZEXac2o/RYYTlT2ycuEzYg0n0gkRA7ApR9uNVeNy6Ili4uYPeiPY/s9JPMkZ1alg0yPg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=ispras.ru; dkim=pass (1024-bit key; unprotected) header.d=ispras.ru header.i=@ispras.ru header.a=rsa-sha256 header.s=default header.b=QD19GFDn; dkim-atps=neutral; spf=pass (client-ip=83.149.199.84; helo=mail.ispras.ru; envelope-from=pchelkin@ispras.ru; receiver=lists.ozlabs.org) smtp.mailfrom=ispras.ru
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=ispras.ru
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=ispras.ru header.i=@ispras.ru header.a=rsa-sha256 header.s=default header.b=QD19GFDn;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=ispras.ru (client-ip=83.149.199.84; helo=mail.ispras.ru; envelope-from=pchelkin@ispras.ru; receiver=lists.ozlabs.org)
Received: from mail.ispras.ru (mail.ispras.ru [83.149.199.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Z5tZd4NmDz2xX3
	for <linux-erofs@lists.ozlabs.org>; Mon,  3 Mar 2025 20:20:22 +1100 (AEDT)
Received: from localhost (unknown [10.10.165.8])
	by mail.ispras.ru (Postfix) with ESMTPSA id 8831B40777AA;
	Mon,  3 Mar 2025 09:19:47 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.ispras.ru 8831B40777AA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ispras.ru;
	s=default; t=1740993587;
	bh=yIKMCXjADGPI9vSNBDHS/nd+SYypPRjQI0Yuanov3Qo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QD19GFDnVVSEW2TPegnX5m+IPQD8wVX37hdWPaB/UAca3TyA7LdBSYAGiq90pL1UE
	 1EFflh50LWMZruaNbXDPr/WkuGwxpJq8R46YRtYmvz1OM7gawDBePpqo56iGTdn0r1
	 ldKi4jkplYJ34W28PyZRfaZniDUKOhvTrTERuJdA=
Date: Mon, 3 Mar 2025 12:19:47 +0300
From: Fedor Pchelkin <pchelkin@ispras.ru>
To: Gao Xiang <hsiangkao@linux.alibaba.com>
Subject: Re: [PATCH 6.1 1/2] erofs: handle overlapped pclusters out of
 crafted images properly
Message-ID: <whxlizkpoqifmcvjbxt35bnj5jpc5cx6wzy3nq47zteu5pefq3@umdsbzhl3wqm>
References: <20250228165103.26775-1-apanov@astralinux.ru>
 <20250228165103.26775-2-apanov@astralinux.ru>
 <kcsbxadkk4wow7554zonb6cjvzmkh2pbncsvioloucv3npvbtt@rpthpmo7cjja>
 <fb801c0f-105e-4aa7-80e2-fcf622179446@linux.alibaba.com>
 <3vutme7tf24cqdfbf4wjti22u6jfxjewe6gt4ufppp4xplyb5e@xls7aozstoqr>
 <0417518e-d02e-48a9-a9ce-8d2be53bc1bd@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <0417518e-d02e-48a9-a9ce-8d2be53bc1bd@linux.alibaba.com>
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS autolearn=disabled
	version=4.0.0
X-Spam-Checker-Version: SpamAssassin 4.0.0 (2022-12-13) on lists.ozlabs.org
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
Cc: Max Kellermann <max.kellermann@ionos.com>, lvc-project@linuxtesting.org, syzbot+de04e06b28cfecf2281c@syzkaller.appspotmail.com, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Chao Yu <chao@kernel.org>, linux-erofs@lists.ozlabs.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org, Alexey Panov <apanov@astralinux.ru>, Yue Hu <huyue2@coolpad.com>, syzbot+4fc98ed414ae63d1ada2@syzkaller.appspotmail.com, syzbot+c8c8238b394be4a1087d@syzkaller.appspotmail.com
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On Mon, 03. Mar 08:31, Gao Xiang wrote:
> On 2025/3/3 02:13, Fedor Pchelkin wrote:
> > My concern was that in 6.1 and 6.6 there is still a pattern at that
> > place, not directly related to 2080ca1ed3e4 ("erofs: tidy up
> > `struct z_erofs_bvec`"):
> > 
> > 1. checking ->private against Z_EROFS_PREALLOCATED_PAGE
> > 2. zeroing out ->private if the previous check holds true
> > 
> > // 6.1/6.6 fragment
> > 
> > 	if (page->private == Z_EROFS_PREALLOCATED_PAGE) {
> > 		WRITE_ONCE(pcl->compressed_bvecs[nr].page, page);
> > 		set_page_private(page, 0);
> > 		tocache = true;
> > 		goto out_tocache;
> > 	}
> > 
> > while the upstream patch changed the situation. If it's okay then no
> > remarks from me. Sorry for the noise..
> 
> Yeah, yet as I mentioned `set_page_private(page, 0);`
> seems redundant from the codebase, I'm fine with either
> way.

Somehow I've written that mail without seeing your last reply there first.
Now everything is clear.

I'll kindly ask Alexey to send the v2 with minor adjustments to
generally non-minor merge conflict resolutions and the backporter's
comment though.

And again, thanks for clarifying all this.
