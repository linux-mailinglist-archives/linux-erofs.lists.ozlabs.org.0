Return-Path: <linux-erofs+bounces-1536-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:21b9:f100::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B029DCD7AC3
	for <lists+linux-erofs@lfdr.de>; Tue, 23 Dec 2025 02:33:45 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4dZyFz2G65z2xdY;
	Tue, 23 Dec 2025 12:33:43 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=113.46.200.226
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1766453623;
	cv=none; b=T23xnbpKEHCc2QCATU/UiDE1UMq68c9TH7HFUBBQAQ98OKUOZex0N0eIhlKnVOmRwuiBaOq52h4yMB6mIj8dZotxbkbFXOruRf0AVc5LBKazY37Gyjh0HfUgQ2tttBJj7dwUveaAxZD3Ug/5LO2po6xTEtNsKNX132953MQCmhhHTixupKmLRTidRJW6oihhgI7qMgj47LRBVeXMMDmF/tX+bJBSURkgPlO1xclG6bUrEE+LTEr3ASGQMDukQbUeUOFQlzV4EZRaoVoYWR12Y/7vnm3lT1/X7eZQK107Cmd2+5BKmiZMk2B31N3PfE3sffnPVH7y9K4ay52BuChzmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1766453623; c=relaxed/relaxed;
	bh=LQm9covx3GTV+Z5lbScFnu7smbApECi0DeHgk1lrvDc=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=I622cDzyJM32Q7WdMcPGILW8xPugRT2ng2YG5+utMzZcL251o6RljMaFMT4U9yFw+L7KoeSQ3URfJ6fOUzGvu8v6dguH5BivIU3sTDpRNrtUrgHE93Y2JorHDCNWMeC2aKRAwwcGHajGC86FIXh80CYaxOlTWcO+/J1yeIz3+NZYPI/KsBbNR2fN/kAlMkaPn/Xyee9nLEYOJhiSC4ph4j2UyZ7P20sROe/YVG/UbIAMiJ0/XyxTj0ikIPv96FIe7OkRNrEKR7EUsmEb2BpQIJIN1UzZyj889VeqlsKhfSuiJVcQEEmf7M9F3rRNk1V+0ceRka9bsHTpoYQkNuXp6A==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; dkim=pass (1024-bit key; unprotected) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=0a3cO1kk; dkim-atps=neutral; spf=pass (client-ip=113.46.200.226; helo=canpmsgout11.his.huawei.com; envelope-from=zhaoyifan28@huawei.com; receiver=lists.ozlabs.org) smtp.mailfrom=huawei.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=0a3cO1kk;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=huawei.com (client-ip=113.46.200.226; helo=canpmsgout11.his.huawei.com; envelope-from=zhaoyifan28@huawei.com; receiver=lists.ozlabs.org)
Received: from canpmsgout11.his.huawei.com (canpmsgout11.his.huawei.com [113.46.200.226])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4dZyFv390Bz2x99
	for <linux-erofs@lists.ozlabs.org>; Tue, 23 Dec 2025 12:33:37 +1100 (AEDT)
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=LQm9covx3GTV+Z5lbScFnu7smbApECi0DeHgk1lrvDc=;
	b=0a3cO1kkIy0JK5zsqSrGrw2Zb4zT0P78O5hynLEaDMQBKjcxYb2ljvusndADtlWntSMnx9a8v
	08psX7FYL6Vo1UA0xkg20pKXZl+fyF+eGVmvfo+z2XlJR07ROE0vhrHnKKgIPVkP2HkaUdMOco2
	Decs3q9Wc42qm36N59lYv+E=
Received: from mail.maildlp.com (unknown [172.19.163.127])
	by canpmsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4dZyB85dmZzKm5B;
	Tue, 23 Dec 2025 09:30:24 +0800 (CST)
Received: from kwepemr100010.china.huawei.com (unknown [7.202.195.125])
	by mail.maildlp.com (Postfix) with ESMTPS id 9408B4056B;
	Tue, 23 Dec 2025 09:33:31 +0800 (CST)
Received: from [100.103.109.96] (100.103.109.96) by
 kwepemr100010.china.huawei.com (7.202.195.125) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.36; Tue, 23 Dec 2025 09:33:31 +0800
Message-ID: <f524ed72-e13b-4346-b169-1f9cda96fdb7@huawei.com>
Date: Tue, 23 Dec 2025 09:33:30 +0800
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
To: Gao Xiang <hsiangkao@linux.alibaba.com>, <linux-erofs@lists.ozlabs.org>
References: <20251222074652.1947729-1-hsiangkao@linux.alibaba.com>
 <20251222074652.1947729-2-hsiangkao@linux.alibaba.com>
From: "zhaoyifan (H)" <zhaoyifan28@huawei.com>
In-Reply-To: <20251222074652.1947729-2-hsiangkao@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [100.103.109.96]
X-ClientProxiedBy: kwepems200001.china.huawei.com (7.221.188.67) To
 kwepemr100010.china.huawei.com (7.202.195.125)
X-Spam-Status: No, score=-0.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS autolearn=disabled
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org


On 2025/12/22 15:46, Gao Xiang wrote:
> Users can use the new `--disconnect` option to forcibly disconnect or
> abort NBD block devices.
>
> Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>

Hi Xiang,

It seems

     mount.erofs -u /dev/nbdX

serving the same purpose of --disconnect? Why do we need a separate 
--disconnect subcommand?


Thanks,

Yifan

> ---
>   mount/main.c | 55 +++++++++++++++++++++++++++++++++++++++++++++-------
>   1 file changed, 48 insertions(+), 7 deletions(-)
>
> diff --git a/mount/main.c b/mount/main.c
> index b3b2e0fc33e0..693dba2dc78d 100644
> --- a/mount/main.c
> +++ b/mount/main.c
> @@ -51,6 +51,7 @@ enum erofs_backend_drv {
>   enum erofsmount_mode {
>   	EROFSMOUNT_MODE_MOUNT,
>   	EROFSMOUNT_MODE_UMOUNT,
> +	EROFSMOUNT_MODE_DISCONNECT,
>   	EROFSMOUNT_MODE_REATTACH,
>   };
>   
> @@ -88,13 +89,14 @@ static void usage(int argc, char **argv)
>   		"Manage EROFS filesystem.\n"
>   		"\n"
>   		"General options:\n"
> -		" -V, --version		print the version number of mount.erofs and exit\n"
> -		" -h, --help		display this help and exit\n"
> -		" -o options		comma-separated list of mount options\n"
> -		" -t type[.subtype]	filesystem type (and optional subtype)\n"
> -		" 			subtypes: fuse, local, nbd\n"
> -		" -u 			unmount the filesystem\n"
> -		"    --reattach		reattach to an existing NBD device\n"
> +		" -V, --version         print the version number of mount.erofs and exit\n"
> +		" -h, --help            display this help and exit\n"
> +		" -o options            comma-separated list of mount options\n"
> +		" -t type[.subtype]     filesystem type (and optional subtype)\n"
> +		"                       subtypes: fuse, local, nbd\n"
> +		" -u                    unmount the filesystem\n"
> +		"    --disconnect       abort an existing NBD device forcibly\n"
> +		"    --reattach         reattach to an existing NBD device\n"
>   #ifdef OCIEROFS_ENABLED
>   		"\n"
>   		"OCI-specific options (with -o):\n"
> @@ -271,6 +273,7 @@ static int erofsmount_parse_options(int argc, char **argv)
>   		{"help", no_argument, 0, 'h'},
>   		{"version", no_argument, 0, 'V'},
>   		{"reattach", no_argument, 0, 512},
> +		{"disconnect", no_argument, 0, 513},
>   		{0, 0, 0, 0},
>   	};
>   	char *dot;
> @@ -316,6 +319,9 @@ static int erofsmount_parse_options(int argc, char **argv)
>   		case 512:
>   			mountcfg.mountmode = EROFSMOUNT_MODE_REATTACH;
>   			break;
> +		case 513:
> +			mountcfg.mountmode = EROFSMOUNT_MODE_DISCONNECT;
> +			break;
>   		default:
>   			return -EINVAL;
>   		}
> @@ -1415,6 +1421,33 @@ err_out:
>   	return err < 0 ? err : 0;
>   }
>   
> +static int erofsmount_disconnect(const char *target)
> +{
> +	int nbdnum, err, fd;
> +	struct stat st;
> +
> +	err = lstat(target, &st);
> +	if (err < 0)
> +		return -errno;
> +
> +	if (!S_ISBLK(st.st_mode) || major(st.st_rdev) != EROFS_NBD_MAJOR)
> +		return -ENOTBLK;
> +
> +	nbdnum = erofs_nbd_get_index_from_minor(minor(st.st_rdev));
> +	err = erofs_nbd_nl_disconnect(nbdnum);
> +	if (err == -EOPNOTSUPP) {
> +		fd = open(target, O_RDWR);
> +		if (fd < 0) {
> +			err = -errno;
> +			goto err_out;
> +		}
> +		err = erofs_nbd_disconnect(fd);
> +		close(fd);
> +	}
> +err_out:
> +	return err < 0 ? err : 0;
> +}
> +
>   int main(int argc, char *argv[])
>   {
>   	int err;
> @@ -1443,6 +1476,14 @@ int main(int argc, char *argv[])
>   		return err ? EXIT_FAILURE : EXIT_SUCCESS;
>   	}
>   
> +	if (mountcfg.mountmode == EROFSMOUNT_MODE_DISCONNECT) {
> +		err = erofsmount_disconnect(mountcfg.target);
> +		if (err < 0)
> +			fprintf(stderr, "Failed to disconnect %s: %s\n",
> +				mountcfg.target, erofs_strerror(err));
> +		return err ? EXIT_FAILURE : EXIT_SUCCESS;
> +	}
> +
>   	if (mountcfg.backend == EROFSFUSE) {
>   		err = erofsmount_fuse(mountcfg.device, mountcfg.target,
>   				      mountcfg.fstype, mountcfg.full_options);

