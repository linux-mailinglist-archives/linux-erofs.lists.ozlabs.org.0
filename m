Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	by mail.lfdr.de (Postfix) with ESMTPS id DAA8291630
	for <lists+linux-erofs@lfdr.de>; Sun, 18 Aug 2019 12:40:08 +0200 (CEST)
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 46BD8k340wzDrCG
	for <lists+linux-erofs@lfdr.de>; Sun, 18 Aug 2019 20:40:06 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=kernel.org
 (client-ip=198.145.29.99; helo=mail.kernel.org; envelope-from=chao@kernel.org;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=kernel.org header.i=@kernel.org header.b="CsD7cjaN"; 
 dkim-atps=neutral
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 46BD8f0SXwzDr6w
 for <linux-erofs@lists.ozlabs.org>; Sun, 18 Aug 2019 20:40:01 +1000 (AEST)
Received: from [192.168.0.101] (unknown [180.111.132.43])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id CB5402173B;
 Sun, 18 Aug 2019 10:39:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1566124798;
 bh=NZToQaeJzz8Ty+Y0B57dsWw46aBahEhnOAkutIVO54Y=;
 h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
 b=CsD7cjaN8Kycm4SVNR7vGn1g2VrzQcmT40WDMLnYfOS6oeI6RVJVrJd+vn4F/oW5e
 Lonw4lm85ZI/xRvSs4p4tNebnaWPfW2rGYI6V5fcdfC8IXMnZiyPxB4kiCybncg2rf
 NoXjpYAKkJLM7wzG/WfrfT3xQ8H9xja220BFAKmE=
Subject: Re: [PATCH v2] staging: erofs: fix an error handling in
 erofs_readdir()
To: Matthew Wilcox <willy@infradead.org>, Gao Xiang <hsiangkao@aol.com>
References: <20190818014835.5874-1-hsiangkao@aol.com>
 <20190818015631.6982-1-hsiangkao@aol.com>
 <20190818022055.GA14592@bombadil.infradead.org>
 <20190818023240.GA7739@hsiangkao-HP-ZHAN-66-Pro-G1>
 <20190818025339.GB14592@bombadil.infradead.org>
From: Chao Yu <chao@kernel.org>
Message-ID: <c624d057-cd42-515c-cff8-cf68340401e0@kernel.org>
Date: Sun, 18 Aug 2019 18:39:52 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20190818025339.GB14592@bombadil.infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
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
Cc: devel@driverdev.osuosl.org, Richard Weinberger <richard@nod.at>,
 Miao Xie <miaoxie@huawei.com>, LKML <linux-kernel@vger.kernel.org>,
 stable@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 linux-fsdevel@vger.kernel.org, linux-erofs@lists.ozlabs.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On 2019-8-18 10:53, Matthew Wilcox wrote:
> On Sun, Aug 18, 2019 at 10:32:45AM +0800, Gao Xiang wrote:
>> On Sat, Aug 17, 2019 at 07:20:55PM -0700, Matthew Wilcox wrote:
>>> On Sun, Aug 18, 2019 at 09:56:31AM +0800, Gao Xiang wrote:
>>>> @@ -82,8 +82,12 @@ static int erofs_readdir(struct file *f, struct dir_context *ctx)
>>>>  		unsigned int nameoff, maxsize;
>>>>  
>>>>  		dentry_page = read_mapping_page(mapping, i, NULL);
>>>> -		if (IS_ERR(dentry_page))
>>>> -			continue;
>>>> +		if (IS_ERR(dentry_page)) {
>>>> +			errln("fail to readdir of logical block %u of nid %llu",
>>>> +			      i, EROFS_V(dir)->nid);
>>>> +			err = PTR_ERR(dentry_page);
>>>> +			break;
>>>
>>> I don't think you want to use the errno that came back from
>>> read_mapping_page() (which is, I think, always going to be -EIO).
>>> Rather you want -EFSCORRUPTED, at least if I understand the recent
>>> patches to ext2/ext4/f2fs/xfs/...
>>
>> Thanks for your reply and noticing this. :)
>>
>> Yes, as I talked with you about read_mapping_page() in a xfs related
>> topic earlier, I think I fully understand what returns here.
>>
>> I actually had some concern about that before sending out this patch.
>> You know the status is
>>    PG_uptodate is not set and PG_error is set here.
>>
>> But we cannot know it is actually a disk read error or due to
>> corrupted images (due to lack of page flags or some status, and
>> I think it could be a waste of page structure space for such
>> corrupted image or disk error)...
>>
>> And some people also like propagate errors from insiders...
>> (and they could argue about err = -EFSCORRUPTED as well..)
>>
>> I'd like hear your suggestion about this after my words above?
>> still return -EFSCORRUPTED?
> 
> I don't think it matters whether it's due to a disk error or a corrupted
> image.  We can't read the directory entry, so we should probably return
> -EFSCORRUPTED.  Thinking about it some more, read_mapping_page() can
> also return -ENOMEM, so it should probably look something like this:
> 
> 		err = 0;
> 		if (dentry_page == ERR_PTR(-ENOMEM))
> 			err = -ENOMEM;
> 		else if (IS_ERR(dentry_page)) {
> 			errln("fail to readdir of logical block %u of nid %llu",
> 			      i, EROFS_V(dir)->nid);
> 			err = -EFSCORRUPTED;

Well, if there is real IO error happen under filesystem, we should return -EIO
instead of EFSCORRUPTED?

The right fix may be that doing sanity check on on-disk blkaddr, and return
-EFSCORRUPTED if the blkaddr is invalid and propagate the error to its caller
erofs_readdir(), IIUC below error info.

> [36297.354090] attempt to access beyond end of device
> [36297.354098] loop17: rw=0, want=29887428984, limit=1953128
> [36297.354107] attempt to access beyond end of device
> [36297.354109] loop17: rw=0, want=29887428480, limit=1953128
> [36301.827234] attempt to access beyond end of device
> [36301.827243] loop17: rw=0, want=29887428480, limit=1953128

Thanks,

> 		}
> 
> 		if (err)
> 			break;
> 
