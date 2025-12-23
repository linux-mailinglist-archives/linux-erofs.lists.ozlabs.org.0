Return-Path: <linux-erofs+bounces-1547-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:21b9:f100::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DC8ACD7D31
	for <lists+linux-erofs@lfdr.de>; Tue, 23 Dec 2025 03:10:09 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4dZz3z2F5Hz2xlP;
	Tue, 23 Dec 2025 13:10:07 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.132
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1766455807;
	cv=none; b=KBoyogTpayRPjqxtbH4+SjsaFEsVDP8xhcYBFYqVnQQB1Fs9pPUMeA5PqT0shY12FCqtR6cb1qAVTP/lVAjfgtUDo46vGHWwKzHJHndCrfXoeYnrxOtjXmjl++z16OFsDJ5NVvRmfm5lanj+pO5dU7a4BHNYuxRsF/gsW7co12cRYY309/XLCLvQAuyljMomyZhNC7wOwTpqIxhZlFzbD0BQpAZeKyHkqGG8HpWM6TAcke1+0HnN2O/JKL1c6FOs44iTMMzXCMqCPzFVtabRnPjsOVF+qUBYEp3X9NgZt5tmuq3qiTYSRsQ+Uk2h24uBeQqE7HkLBGvU1YrNKHtDjA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1766455807; c=relaxed/relaxed;
	bh=vu3z4+c3ida8+rkrpY7yNxJ9zF41Gz9qP/cAKXr30u0=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=FzbvOAJgE42MkK14LO35JXjpuIXJeisllB9H1nIzmxtxxEFtN8Kddi1lFu5Htl2rYaxNI0Mmj0rGGOsra/K5+7zMQqbmz5XvPn+LiX/2oN64o6DehNnO4KD+lJzTNl8Lt9jype5DYem457Xe1u3MC5p/uPnQ1sCJdbNo7tHc6cYmAgaBUGV6pnbJqEzWUO9zcDH6cuf4mGV/L2+eZOxPjogoWfGXbfozgLbbPYeVBIleagLCE69CfuILoZyyJo8TQRTvZH472nT0/89KvL/TJzMqKCOL+Gru0t71sZh8UXSfmypgO+Ol3coG1Vy4kOp5xAZaC5T9HWkCIClpmnqzSw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=Tutu34HM; dkim-atps=neutral; spf=pass (client-ip=115.124.30.132; helo=out30-132.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=Tutu34HM;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.132; helo=out30-132.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-132.freemail.mail.aliyun.com (out30-132.freemail.mail.aliyun.com [115.124.30.132])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4dZz3x1pTRz2xdY
	for <linux-erofs@lists.ozlabs.org>; Tue, 23 Dec 2025 13:10:04 +1100 (AEDT)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1766455795; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=vu3z4+c3ida8+rkrpY7yNxJ9zF41Gz9qP/cAKXr30u0=;
	b=Tutu34HMabcH5h+rWBGy3llfI98BmSIBacHMcB43iOrXZ6OG0XDEO+ZeDPtaMaM4sBOlV9sebL1XWzx1q1E4EZ0jUvWt7aCPq3HUNFpCXa9YTUvW60Y4Sp0xYqFiQsbHO6ClMEao4BBNUShrpkRiuupl1ZO3SiCwRP9g5N53Xl0=
Received: from 30.221.131.244(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WvVtAoF_1766455793 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 23 Dec 2025 10:09:53 +0800
Message-ID: <4e2dcbf3-7e39-475e-9de4-caacbdce869d@linux.alibaba.com>
Date: Tue, 23 Dec 2025 10:09:52 +0800
X-Mailing-List: linux-erofs@lists.ozlabs.org
List-Id: <linux-erofs.lists.ozlabs.org>
List-Help: <mailto:linux-erofs+help@lists.ozlabs.org>
List-Owner: <mailto:linux-erofs+owner@lists.ozlabs.org>
List-Post: <mailto:linux-erofs@lists.ozlabs.org>
List-Subscribe: <mailto:linux-erofs+subscribe@lists.ozlabs.org>,
  <mailto:linux-erofs+subscribe-digest@lists.ozlabs.org>,
  <mailto:linux-erofs+subscribe-nomail@lists.ozlabs.org>
List-Unsubscribe: <mailto:linux-erofs+unsubscribe@lists.ozlabs.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] erofs-utils: mount: add `--disconnect` command
To: "zhaoyifan (H)" <zhaoyifan28@huawei.com>, linux-erofs@lists.ozlabs.org
References: <20251222074652.1947729-1-hsiangkao@linux.alibaba.com>
 <20251222074652.1947729-2-hsiangkao@linux.alibaba.com>
 <f524ed72-e13b-4346-b169-1f9cda96fdb7@huawei.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <f524ed72-e13b-4346-b169-1f9cda96fdb7@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-15.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,
	RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org



On 2025/12/23 09:33, zhaoyifan (H) wrote:
> 
> On 2025/12/22 15:46, Gao Xiang wrote:
>> Users can use the new `--disconnect` option to forcibly disconnect or
>> abort NBD block devices.
>>
>> Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
> 
> Hi Xiang,
> 
> It seems
> 
>      mount.erofs -u /dev/nbdX
> 
> serving the same purpose of --disconnect? Why do we need a separate --disconnect subcommand?

It won't handle unmount, just forcibly send
the disconnect command.  It's up to users
to run umount instead.

Thanks,
Gao Xiang

> 
> 
> Thanks,
> 
> Yifan
> 
>> ---
>>   mount/main.c | 55 +++++++++++++++++++++++++++++++++++++++++++++-------
>>   1 file changed, 48 insertions(+), 7 deletions(-)
>>
>> diff --git a/mount/main.c b/mount/main.c
>> index b3b2e0fc33e0..693dba2dc78d 100644
>> --- a/mount/main.c
>> +++ b/mount/main.c
>> @@ -51,6 +51,7 @@ enum erofs_backend_drv {
>>   enum erofsmount_mode {
>>       EROFSMOUNT_MODE_MOUNT,
>>       EROFSMOUNT_MODE_UMOUNT,
>> +    EROFSMOUNT_MODE_DISCONNECT,
>>       EROFSMOUNT_MODE_REATTACH,
>>   };
>> @@ -88,13 +89,14 @@ static void usage(int argc, char **argv)
>>           "Manage EROFS filesystem.\n"
>>           "\n"
>>           "General options:\n"
>> -        " -V, --version        print the version number of mount.erofs and exit\n"
>> -        " -h, --help        display this help and exit\n"
>> -        " -o options        comma-separated list of mount options\n"
>> -        " -t type[.subtype]    filesystem type (and optional subtype)\n"
>> -        "             subtypes: fuse, local, nbd\n"
>> -        " -u             unmount the filesystem\n"
>> -        "    --reattach        reattach to an existing NBD device\n"
>> +        " -V, --version         print the version number of mount.erofs and exit\n"
>> +        " -h, --help            display this help and exit\n"
>> +        " -o options            comma-separated list of mount options\n"
>> +        " -t type[.subtype]     filesystem type (and optional subtype)\n"
>> +        "                       subtypes: fuse, local, nbd\n"
>> +        " -u                    unmount the filesystem\n"
>> +        "    --disconnect       abort an existing NBD device forcibly\n"
>> +        "    --reattach         reattach to an existing NBD device\n"
>>   #ifdef OCIEROFS_ENABLED
>>           "\n"
>>           "OCI-specific options (with -o):\n"
>> @@ -271,6 +273,7 @@ static int erofsmount_parse_options(int argc, char **argv)
>>           {"help", no_argument, 0, 'h'},
>>           {"version", no_argument, 0, 'V'},
>>           {"reattach", no_argument, 0, 512},
>> +        {"disconnect", no_argument, 0, 513},
>>           {0, 0, 0, 0},
>>       };
>>       char *dot;
>> @@ -316,6 +319,9 @@ static int erofsmount_parse_options(int argc, char **argv)
>>           case 512:
>>               mountcfg.mountmode = EROFSMOUNT_MODE_REATTACH;
>>               break;
>> +        case 513:
>> +            mountcfg.mountmode = EROFSMOUNT_MODE_DISCONNECT;
>> +            break;
>>           default:
>>               return -EINVAL;
>>           }
>> @@ -1415,6 +1421,33 @@ err_out:
>>       return err < 0 ? err : 0;
>>   }
>> +static int erofsmount_disconnect(const char *target)
>> +{
>> +    int nbdnum, err, fd;
>> +    struct stat st;
>> +
>> +    err = lstat(target, &st);
>> +    if (err < 0)
>> +        return -errno;
>> +
>> +    if (!S_ISBLK(st.st_mode) || major(st.st_rdev) != EROFS_NBD_MAJOR)
>> +        return -ENOTBLK;
>> +
>> +    nbdnum = erofs_nbd_get_index_from_minor(minor(st.st_rdev));
>> +    err = erofs_nbd_nl_disconnect(nbdnum);
>> +    if (err == -EOPNOTSUPP) {
>> +        fd = open(target, O_RDWR);
>> +        if (fd < 0) {
>> +            err = -errno;
>> +            goto err_out;
>> +        }
>> +        err = erofs_nbd_disconnect(fd);
>> +        close(fd);
>> +    }
>> +err_out:
>> +    return err < 0 ? err : 0;
>> +}
>> +
>>   int main(int argc, char *argv[])
>>   {
>>       int err;
>> @@ -1443,6 +1476,14 @@ int main(int argc, char *argv[])
>>           return err ? EXIT_FAILURE : EXIT_SUCCESS;
>>       }
>> +    if (mountcfg.mountmode == EROFSMOUNT_MODE_DISCONNECT) {
>> +        err = erofsmount_disconnect(mountcfg.target);
>> +        if (err < 0)
>> +            fprintf(stderr, "Failed to disconnect %s: %s\n",
>> +                mountcfg.target, erofs_strerror(err));
>> +        return err ? EXIT_FAILURE : EXIT_SUCCESS;
>> +    }
>> +
>>       if (mountcfg.backend == EROFSFUSE) {
>>           err = erofsmount_fuse(mountcfg.device, mountcfg.target,
>>                         mountcfg.fstype, mountcfg.full_options);


