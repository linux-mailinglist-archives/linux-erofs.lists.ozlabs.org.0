Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AFEF78ED90
	for <lists+linux-erofs@lfdr.de>; Thu, 31 Aug 2023 14:48:16 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Rc1DG0cHmz3bTt
	for <lists+linux-erofs@lfdr.de>; Thu, 31 Aug 2023 22:48:14 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=sjtu.edu.cn (client-ip=202.120.2.237; helo=smtp237.sjtu.edu.cn; envelope-from=lyy0627@sjtu.edu.cn; receiver=lists.ozlabs.org)
Received: from smtp237.sjtu.edu.cn (smtp237.sjtu.edu.cn [202.120.2.237])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Rc1D85Dc5z307h
	for <linux-erofs@lists.ozlabs.org>; Thu, 31 Aug 2023 22:48:06 +1000 (AEST)
Received: from proxy189.sjtu.edu.cn (smtp189.sjtu.edu.cn [202.120.2.189])
	by smtp237.sjtu.edu.cn (Postfix) with ESMTPS id 11ABC7FAC7;
	Thu, 31 Aug 2023 20:48:00 +0800 (CST)
Received: from [192.168.31.108] (unknown [139.227.253.35])
	by proxy189.sjtu.edu.cn (Postfix) with ESMTPSA id 9F2513FC424;
	Thu, 31 Aug 2023 20:47:53 +0800 (CST)
Message-ID: <a47e744f-19df-46c6-96a9-cb6c7d000441@sjtu.edu.cn>
Date: Thu, 31 Aug 2023 20:47:43 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7] erofs-utils: add support for fuse 2/3 lowlevel API
To: Gao Xiang <hsiangkao@linux.alibaba.com>,
 Huang Jianan <jnhuang95@gmail.com>, linux-erofs@lists.ozlabs.org
References: <20230823115955.3679838-1-lyy0627@sjtu.edu.cn>
 <CAJfKizqAuRTndcq+jQAAn=H2rD1bqcg6Mek0x4KHxrAfPwe2MQ@mail.gmail.com>
 <54abca78-bdc7-9520-4e95-75f32f451a5c@sjtu.edu.cn>
 <20bba3e8-9503-b116-df69-80046d40ba01@linux.alibaba.com>
From: Li Yiyan <lyy0627@sjtu.edu.cn>
In-Reply-To: <20bba3e8-9503-b116-df69-80046d40ba01@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
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
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Hi Xiang,

Thank you for your reminder, I will reconsider the reply_err part.

Here is more information about the workaround. It can be considered that
the return of size=0 is an interface specification that users should follow.

https://github.com/philips/attr/blob/master/getfattr/getfattr.c#L298

I will complete the modification of the lib in V8 and delete the workaround.

On 2023/8/31 19:05, Gao Xiang wrote:
> 
> 
> On 2023/8/31 18:48, Li Yiyan wrote:
> 
> ...
> 
>>>> +
>>>> +     vi->sbi = &sbi;
>>>> +     vi->nid = (erofs_nid_t)ino;
>>>> +     ret = erofs_read_inode_from_disk(vi);
>>>> +     if (ret < 0) {
>>>> +             fuse_reply_err(req, EIO);
>>>
>>> Maybe reply -ret? Since there are other errors in
>>> erofs_read_inode_from_disk.
>>
>> No. As mentioned in declaration, param err represents the *positive* error value,
>> or zero for success.
> 
> I think Jianan meant:
>     if (ret < 0) {
>         fuse_reply_err(req, -err);
> 
> instead.
> 
>>>
> 
> ...
> 
>>>
>>>> +             return;
>>>> +     }
>>>> +
>>>> +     if (bufsize == 0)
>>>> +             bufsize = EROFSFUSE_XATTR_BUF_SIZE;
>>>
>>> Why do we need to reconfigure bufsize here? erofs_listxattr should
>>> handle bufsize of 0.
>>
>>
>> This is a workaround for the time being, I will propose a patch to modify the lib
>> to solve this problem.
>>
>> As mentioned in https://man7.org/linux/man-pages/man2/listxattr.2.html:
>>
>> "If size is specified as zero, these calls return the current size of the list of
>> extended attribute names ( and leave list unchanged). This can be used to determine
>> the size of the buffer that should be supplied in a subsequent call."
>>
>> Therefore, buf=0 means that we need to use fuse_reply_xattr to return the requested
>> size of the buffer. Only when buf is not 0 do we need to copy xattr to buffer.
>> At present, the erofs_getxattr cannot solve this problem, so a workaround is
>> made on the fuse layer to temporarily solve this problem and
>> control the extent of the patch.
> 
> Are you sure that erofs_listxattr() cannot accept NULL buffers?
> I'm totally confused.
> 
> Anyway, if erofs_listxattr() unmeet your requirement for whatever
> reasons, please fix this instead.
> 
> Thanks,
> Gao Xiang

Thanks,
Yiyan
