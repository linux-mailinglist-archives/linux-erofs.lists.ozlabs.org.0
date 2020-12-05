Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 41CB62CFABE
	for <lists+linux-erofs@lfdr.de>; Sat,  5 Dec 2020 10:07:47 +0100 (CET)
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Cp3cw2SdNzDqnl
	for <lists+linux-erofs@lfdr.de>; Sat,  5 Dec 2020 20:07:44 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.ozlabs.org;
	s=201707; t=1607159264;
	bh=9UMqJCwJi3/rCFNODXLSGOx5mYSEf8+BVHp6Q3Xd+bU=;
	h=Subject:To:References:Date:In-Reply-To:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:Cc:
	 From;
	b=fqPjqCL9Morw2C27/MVwajZIYKTMELmvosOtQRcePSJv8WxYpxcDl252dEthX2EQ3
	 QQJL979XB/G7PHlwBJ4+3tSx9IXY9kD5T3OoLWtdq5YCaMAEK6ZggozYn/Mr1IFx3f
	 HWGvqC5F0M+J7s6P0eYkkXnrKm5pYnGD3tWD+FwEYGVA3qttKPJyBjjKaNL/NTjKd8
	 +LaYW5KhWTGxujkTaTdlHLsDFviZ71ylkhSIpGg83kg0IK1A9UD7f/uwhqNQo/EM5Z
	 99kyEK+bEElw7aaFXxwFMyOhz6CB/UkX/2bYJPvLZOEBVl4OvQD27Gg2tTEuIueQ7K
	 BrEJHPIVZUNMA==
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=aliyun.com (client-ip=115.124.30.50;
 helo=out30-50.freemail.mail.aliyun.com; envelope-from=bluce.lee@aliyun.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none)
 header.from=aliyun.com
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=aliyun.com header.i=@aliyun.com header.a=rsa-sha256
 header.s=s1024 header.b=mLUEdgfh; dkim-atps=neutral
Received: from out30-50.freemail.mail.aliyun.com
 (out30-50.freemail.mail.aliyun.com [115.124.30.50])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4Cp3Zs02FxzDqlP
 for <linux-erofs@lists.ozlabs.org>; Sat,  5 Dec 2020 20:05:54 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aliyun.com; s=s1024;
 t=1607159136; h=Subject:To:From:Message-ID:Date:MIME-Version:Content-Type;
 bh=L/PROY6hu9gSZJcv+h4HU2azBVYVNY1O+Rh7bS4YewU=;
 b=mLUEdgfh9k6O+2t0ExJf5b2Dng6K8L1BJP3o22F+Sd3dQm9GPtRoEf1Rck/wuCUbIhCR19WbiuIG9M10Tz+YN6xKxouBagyR7mrOrGbOe+PVjCCg34UAWuyK/Fyoswxa6SaN0Aiqhw2OGx9q6xyp8pN7SK0BSAeuBvwzQ+lc4EI=
X-Alimail-AntiSpam: AC=CONTINUE; BC=0.07400145|-1; CH=green;
 DM=|CONTINUE|false|;
 DS=CONTINUE|ham_regular_dialog|0.0128104-0.000970121-0.986219;
 FP=0|0|0|0|0|-1|-1|-1; HT=e01e04400; MF=bluce.lee@aliyun.com; NM=1; PH=DS;
 RN=3; RT=3; SR=0; TI=SMTPD_---0UHa1xpi_1607159135; 
Received: from 172.168.2.18(mailfrom:bluce.lee@aliyun.com
 fp:SMTPD_---0UHa1xpi_1607159135) by smtp.aliyun-inc.com(127.0.0.1);
 Sat, 05 Dec 2020 17:05:36 +0800
Subject: Re: [PATCH] erofs-utils: update i_nlink stat for directories
To: Gao Xiang <hsiangkao@redhat.com>
References: <20201205055732.14276-1-hsiangkao.ref@aol.com>
 <20201205055732.14276-1-hsiangkao@aol.com>
 <ed88d60a-77a9-f189-3586-a6d6aef510d9@aliyun.com>
 <20201205083837.GA2333547@xiangao.remote.csb>
 <20201205084303.GB2333547@xiangao.remote.csb>
Message-ID: <e3594931-7cf2-b91e-cd0c-76c1d1750ab0@aliyun.com>
Date: Sat, 5 Dec 2020 17:05:35 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.1
MIME-Version: 1.0
In-Reply-To: <20201205084303.GB2333547@xiangao.remote.csb>
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
From: Li GuiFu via Linux-erofs <linux-erofs@lists.ozlabs.org>
Reply-To: Li GuiFu <bluce.lee@aliyun.com>
Cc: linux-erofs@lists.ozlabs.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>



On 2020/12/5 16:43, Gao Xiang wrote:
> On Sat, Dec 05, 2020 at 04:38:37PM +0800, Gao Xiang wrote:
>> On Sat, Dec 05, 2020 at 04:32:44PM +0800, Li GuiFu via Linux-erofs wrote:
>>
>> ...
>>
>>>
>>>> @@ -957,6 +974,10 @@ struct erofs_inode *erofs_mkfs_build_tree(struct erofs_inode *dir)
>>>>  			ret = PTR_ERR(d);
>>>>  			goto err_closedir;
>>>>  		}
>>>> +
>>>> +		/* to count i_nlink for directories */
>>>> +		d->type = (dp->d_type == DT_DIR ?
>>>> +			EROFS_FT_DIR : EROFS_FT_UNKNOWN);
>>>>  	}
>>>>  
>>> It's confused that d->type was set to EROFS_FT_UNKNOWN when not a dir
>>> It's not clearness whether the program goes wrong or get the wrong data
>>> Actually it's a correct procedure
>>
>> It's just set temporarily, since only dirs are useful when counting subdirs, so
>> only needs to differ dirs and non-dirs here. (Previously d->type is unused
>> at this time.)
> 
> btw, I once tried to set up d->type via dp->d_type here, but it increases a
> lot of code and seems unnecessary (since deriving from i_mode is enough).
> So again, here we only cares about dir and non-dirs (we don't care much about
> the specific kind of non-dirs here).
> 
> Thanks,
> Gao Xiang
> 
>>
>> ...
>>
>>>> -		d->type = erofs_type_by_mode[d->inode->i_mode >> S_SHIFT];
>>>> +		ftype = erofs_mode_to_ftype(d->inode->i_mode);
>>>> +		DBG_BUGON(d->type != EROFS_FT_UNKNOWN && d->type != ftype);
>>>> +		d->type = ftype;
>>
>> The real on-disk d->type will be set here rather than the above.
Yes, what it makes confused is here, EROFS_FT_UNKNOWN is just temporary.
So how about change to ASSERT at EROFS_FT_DIR

DBG_BUGON(d->type == EROFS_FT_DIR && ftype != EROFS_FT_DIR);
