Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id AD3A7A07375
	for <lists+linux-erofs@lfdr.de>; Thu,  9 Jan 2025 11:38:13 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4YTLpp2db9z3bxR
	for <lists+linux-erofs@lfdr.de>; Thu,  9 Jan 2025 21:38:10 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.131
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1736419087;
	cv=none; b=lLEVR2vkQCgyMjmckVkaqoo3HznJ6PhhBdwmsWkbGZ0p4NpQDtfeuVv/m4nBNKqW80oKAiHUZ7a4Ei5OotvfHV7oIiOTdv4neWF53myUUe543m49hiNiH75R6I7TqbPAzuMnGVkiAj8BqbiDCTSBUORYAjKl3NeUUw9mj0pEZ/Bn9gFFLzH4noTl/hLo1zC91S/8eIgVNiZH6+RwGPo+7eO2oYQ46jNex5OhcLB4LH5/nrjXB7yXj+k9qbeIFpnpUB2GAiQYmnzdkJWlMcDcufbXTX98J4Uq9pNmWz7HU7+js9NFZjaAWd2OfhuKiA9wfR/64MJz6yMQ/GqlB+xKog==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1736419087; c=relaxed/relaxed;
	bh=HmUxdRY4qThvdR9+Hq7mC9r2jdxA2DJE/vkTU19vMs8=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=EyxySMHI+LLh5v4HjLWVKAcio1lsqFmftpMcmOjnEwk1U8J2nMxWs5RpnBO7jI38cYIEwALQL1GZndDOXVAY5vgawwbT3MFXF9usb8tfnWLbHgwiJ3jYtpluFdPQl9NrGp6M2Q0jSwlrHJIe5W2TTzLn6Z/fw8elEPcWYZ5Q2ASF/Pjv3rf2vDU4V2ErRDq2LlPNASduJyCsQwBODMlhnOI7ZAHMKow3rQNVE+Y8TgjUXsUCZKaGxrmQPjnriFFkRG1nZJtgWW5wT+ldDYjrhM8zKpeXdtEhZEwrYqpPN4CQ63LoCXx11KTZpsmQF14B2pVWfKgPAPS3nIGH/Mse2Q==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=sHnWl9gk; dkim-atps=neutral; spf=pass (client-ip=115.124.30.131; helo=out30-131.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=sHnWl9gk;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.131; helo=out30-131.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-131.freemail.mail.aliyun.com (out30-131.freemail.mail.aliyun.com [115.124.30.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4YTLpj37Kfz3bV3
	for <linux-erofs@lists.ozlabs.org>; Thu,  9 Jan 2025 21:38:02 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1736419076; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=HmUxdRY4qThvdR9+Hq7mC9r2jdxA2DJE/vkTU19vMs8=;
	b=sHnWl9gk+Z0Zr8Zjch/LFFVdDkXA73JI1IQV+LxVsa9gL3jiEDSzyL9/P09AjnbLnp1IYozEI6b9wRnKf5HcLs9wmWf4+6KyHHpupEJ3qrYI2B8cRYOp2o5W8JJdnRiPgLa7fQxrcb5+yypfyV8zjBa3HpWdbH3F9NHC+VHqFiQ=
Received: from 30.221.130.138(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WNHNE87_1736419074 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 09 Jan 2025 18:37:55 +0800
Message-ID: <e7af73ff-f951-4144-8d7d-d0fecfbd75da@linux.alibaba.com>
Date: Thu, 9 Jan 2025 18:37:54 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] erofs-utils: dump: Add --cat flag to show file contents
To: Juan Hernandez <jhernand@redhat.com>, linux-erofs@lists.ozlabs.org
References: <20250109095526.71911-1-jhernand@redhat.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <20250109095526.71911-1-jhernand@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-15.7 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_DKIM_WL,
	USER_IN_DEF_SPF_WL autolearn=disabled version=4.0.0
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
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Hi Juan,

On 2025/1/9 17:55, Juan Hernandez wrote:
> This patch adds a new '--cat' flag to the 'dump.erofs' command. When
> used it will write to the standard output the content of the file
> indicated by the '--path' or '--nid' options. For example, if there is a
> '/mydir/myfile.txt' file containg the text 'mytext':
> 
>      $ dump.erofs --cat --path=/mydir/myfile.txt myimage.erofs
>      mytext
> 
> Signed-off-by: Juan Hernandez <jhernand@redhat.com>

Thanks for the patch!
It looks good to me, just minor nits..

> ---
>   dump/main.c      | 72 ++++++++++++++++++++++++++++++++++++++++++++++++
>   man/dump.erofs.1 | 13 +++++++--
>   2 files changed, 83 insertions(+), 2 deletions(-)
> 
> diff --git a/dump/main.c b/dump/main.c
> index 372162e..ed8d44d 100644
> --- a/dump/main.c
> +++ b/dump/main.c
> @@ -26,6 +26,7 @@ struct erofsdump_cfg {
>   	bool show_superblock;
>   	bool show_statistics;
>   	bool show_subdirectories;
> +	bool show_file_content;
>   	erofs_nid_t nid;
>   	const char *inode_path;
>   };
> @@ -80,6 +81,7 @@ static struct option long_options[] = {
>   	{"path", required_argument, NULL, 4},
>   	{"ls", no_argument, NULL, 5},
>   	{"offset", required_argument, NULL, 6},
> +	{"cat", no_argument, NULL, 7},
>   	{0, 0, 0, 0},
>   };
>   
> @@ -123,6 +125,7 @@ static void usage(int argc, char **argv)
>   		" -s              show information about superblock\n"
>   		" --device=X      specify an extra device to be used together\n"
>   		" --ls            show directory contents (INODE required)\n"
> +		" --cat           show file contents (INODE required)\n"
>   		" --nid=#         show the target inode info of nid #\n"
>   		" --offset=#      skip # bytes at the beginning of IMAGE\n"
>   		" --path=X        show the target inode info of path X\n",
> @@ -186,6 +189,9 @@ static int erofsdump_parse_options_cfg(int argc, char **argv)
>   				return -EINVAL;
>   			}
>   			break;
> +		case 7:
> +			dumpcfg.show_file_content = true;
> +			break;
>   		default:
>   			return -EINVAL;
>   		}
> @@ -672,6 +678,63 @@ static void erofsdump_show_superblock(void)
>   			uuid_str);
>   }
>   
> +static void erofsdump_show_file_content(void)
> +{
> +	int err;
> +	struct erofs_inode inode = { .sbi = &g_sbi, .nid = dumpcfg.nid };
> +	size_t buffer_size;
> +	char *buffer_ptr;
> +	erofs_off_t pending_size;
> +	erofs_off_t read_offset;
> +	erofs_off_t read_size;
> +
> +	if (dumpcfg.inode_path) {
> +		err = erofs_ilookup(dumpcfg.inode_path, &inode);
> +		if (err) {
> +			erofs_err("read inode failed @ %s", dumpcfg.inode_path);
> +			return;
> +		}
> +	} else {
> +		err = erofs_read_inode_from_disk(&inode);
> +		if (err) {
> +			erofs_err("read inode failed @ nid %llu", inode.nid | 0ULL);
> +			return;
> +		}
> +	}
> +
> +	if (!S_ISREG(inode.i_mode)) {

I think we could dump raw directory content too.


> +		erofs_err("not a regular file @ nid %llu", inode.nid | 0ULL);
> +		return;
> +	}
> +
> +	buffer_size = erofs_blksiz(inode.sbi);
> +	buffer_ptr = malloc(buffer_size);
> +	if (!buffer_ptr) {
> +		erofs_err("buffer allocation failed @ nid %llu", inode.nid | 0ULL);
> +		return;
> +	}
> +
> +	pending_size = inode.i_size;
> +	read_offset = 0;
> +	while (pending_size > 0) {
> +		read_size = pending_size > buffer_size? buffer_size: pending_size;
> +		err = erofs_pread(&inode, buffer_ptr, read_size, read_offset);
> +		if (err) {
> +			erofs_err("read file failed @ nid %llu", inode.nid | 0ULL);
> +			goto out;
> +		}
> +		pending_size -= read_size;
> +		read_offset += read_size;
> +		fwrite(buffer_ptr, read_size, 1, stdout);
> +	}
> +	fflush(stdout);
> +
> +out:
> +	free(buffer_ptr);
> +}
> +
> +
> +

Reduntant new lines..

Thanks,
Gao Xiang
