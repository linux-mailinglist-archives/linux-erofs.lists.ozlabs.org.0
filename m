Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 790AA647F41
	for <lists+linux-erofs@lfdr.de>; Fri,  9 Dec 2022 09:29:25 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4NT41r6ftMz3bfF
	for <lists+linux-erofs@lfdr.de>; Fri,  9 Dec 2022 19:29:20 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lists.ozlabs.org;
	s=201707; t=1670574560;
	bh=lgXvQW8T8idwqTG2o/i6+KoDTaqrhbyGX00cZFdE/wE=;
	h=Date:Subject:To:References:In-Reply-To:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:
	 From;
	b=Rz0k0iq64PWj9VhcJZ2t/4OcrE799QawTKmSATWB2AR/8OOx5tZIduvTLuMcJ3ooh
	 kmXiRmbjBbOcocH+SJTSgp5N9tH7mbuKxZcP2PODVp/M6pHR4OTkqohDQVyC844IWL
	 sKyUp4oGXA0qCJNh9mST+6j7c7RhS1qfzbSwWTBaQe1Aq+KBBcFmr7iGfD17jvqElx
	 38hhpP66JmAcs5/2pMMjNXJbYyV55dcEwzOIm+t61+l53a1exWU7UfVF2RQEDt3+WM
	 LECgaC083sC7m4M9hURzF9wASejFihbaL+Cp2gRJw8xQtasuNBL0MTxveAWCE5Fx6f
	 ZeNaZNys9wxrA==
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=siddh.me (client-ip=103.117.158.50; helo=sender-of-o50.zoho.in; envelope-from=code@siddh.me; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; secure) header.d=siddh.me header.i=code@siddh.me header.a=rsa-sha256 header.s=zmail header.b=NCjulmO8;
	dkim-atps=neutral
Received: from sender-of-o50.zoho.in (sender-of-o50.zoho.in [103.117.158.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4NT41g1fJvz2x9d
	for <linux-erofs@lists.ozlabs.org>; Fri,  9 Dec 2022 19:29:10 +1100 (AEDT)
ARC-Seal: i=1; a=rsa-sha256; t=1670574545; cv=none; 
	d=zohomail.in; s=zohoarc; 
	b=Kp9f9qDxAe0hlfK5vFCbM5y8/3ZlMd4DRhe7eK3dZ3iJFb/9oIGwRt4KkICv8tjgjnsyJOM6VtXNp5rCSiKqc958LUh4AKIp81x3vwbXRBXyNzANxVIeN1iMjYfJxkZ1hwUd7Omkvxv0Y1Df6xpjKwpKlnsbfauv/tatb3kz8l0=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.in; s=zohoarc; 
	t=1670574545; h=Content-Type:Content-Transfer-Encoding:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To; 
	bh=lgXvQW8T8idwqTG2o/i6+KoDTaqrhbyGX00cZFdE/wE=; 
	b=DjBLN7xsKF/wjkmLQzRNaC5Qo1TaRGtGlVU1EygBU4bESeG0MWzbYUlMdX1HwCUKMj5Aj4lVHBAMaJcug+2ioWywOnEVTr87StiBpALrb9W8nxQ4RELM5rza3LSfWRsW+SI7MYKi9rjrJNiwqZZe+j4qrBOG7FVBlWIwsIlr8rU=
ARC-Authentication-Results: i=1; mx.zohomail.in;
	dkim=pass  header.i=siddh.me;
	spf=pass  smtp.mailfrom=code@siddh.me;
	dmarc=pass header.from=<code@siddh.me>
Received: from [192.168.1.9] (110.226.31.37 [110.226.31.37]) by mx.zoho.in
	with SMTPS id 1670574543792307.4749119019116; Fri, 9 Dec 2022 13:59:03 +0530 (IST)
Message-ID: <7c836cf0-d978-c892-bec8-0992e2347512@siddh.me>
Date: Fri, 9 Dec 2022 13:59:02 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [RFC PATCH] erofs/zmap.c: Bail out when no further region remains
Content-Language: en-US, en-GB, hi-IN
To: linux-kernel <linux-kernel@vger.kernel.org>,
 linux-fsdevel <linux-fsdevel@vger.kernel.org>, Yue Hu <huyue2@coolpad.com>,
 linux-erofs <linux-erofs@lists.ozlabs.org>
References: <Y3MGf3TzgKpAz4IP@B-P7TQMD6M-0146.local>
 <917344b4-4256-6d77-b89b-07fa96ec4539@siddh.me>
 <Y3Nu+TNRp6Fv3L19@B-P7TQMD6M-0146.local>
 <Y5K+p6td52QppRZt@B-P7TQMD6M-0146.local>
In-Reply-To: <Y5K+p6td52QppRZt@B-P7TQMD6M-0146.local>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ZohoMailClient: External
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
From: Siddh Raman Pant via Linux-erofs <linux-erofs@lists.ozlabs.org>
Reply-To: Siddh Raman Pant <code@siddh.me>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On Fri, Dec 09 2022 at 10:20:47 +0530, Gao Xiang wrote:
> Hi Siddh,
> 
> On Tue, Nov 15, 2022 at 06:50:33PM +0800, Gao Xiang wrote:
>> On Tue, Nov 15, 2022 at 03:39:38PM +0530, Siddh Raman Pant via Linux-erofs wrote:
>>> On Tue, 15 Nov 2022 08:54:47 +0530, Gao Xiang wrote:
>>>> I just wonder if we should return -EINVAL for post-EOF cases or
>>>> IOMAP_HOLE with arbitrary length?
>>>
>>> Since it has been observed that length can be zeroed, and we
>>> must stop, I think we should return an error appropriately.
>>>
>>> For a read-only filesystem, we probably don't really need to
>>> care what's after the EOF or in unmapped regions, nothing can
>>> be changed/extended. The definition of IOMAP_HOLE in iomap.h
>>> says it stands for "no blocks allocated, need allocation".
>>
>> For fiemap implementation, yes.  So it looks fine to me.
>>
>> Let's see what other people think.  Anyway, I'd like to apply it later.
>>
> 
> Very sorry for late response.
> 
> I've just confirmed that the reason is that
> 
> 796                 /*
> 797                  * No strict rule how to describe extents for post EOF, yet
> 798                  * we need do like below. Otherwise, iomap itself will get
> 799                  * into an endless loop on post EOF.
> 800                  */
> 801                 if (iomap->offset >= inode->i_size)
> 802                         iomap->length = length + map.m_la - offset;
> 
> Here iomap->length should be length + offset - map.m_la here. Because
> the extent start (map.m_la) is always no more than requested `offset'.
> 
> We should need this code sub-block since userspace (filefrag -v) could
> pass
> ioctl(3, FS_IOC_FIEMAP, {fm_start=0, fm_length=18446744073709551615, fm_flags=0, fm_extent_count=292} => {fm_flags=0, fm_mapped_extents=68, ...}) = 0
> 
> without this sub-block, fiemap could get into a very long loop as below:
> [  574.030856][ T7030] erofs: m_la 70000000 offset 70457397 length 9223372036784318410 m_llen 457398
> [  574.031622][ T7030] erofs: m_la 70000000 offset 70457398 length 9223372036784318409 m_llen 457399
> [  574.032397][ T7030] erofs: m_la 70000000 offset 70457399 length 9223372036784318408 m_llen 457400

Thanks for the detailed explanation!

> So could you fix this as?
> 	iomap->length = length + offset - map.m_la;
> 
> I've already verified it can properly resolve the issue and do the
> correct thing although I'd like to submit this later since we're quite
> close to the merge window.
> 
> Thanks,
> Gao Xiang

Sure, I'll send the patch for now, which can be merged after the window.

Thanks,
Siddh
