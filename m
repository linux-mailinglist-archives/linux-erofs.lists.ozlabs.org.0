Return-Path: <linux-erofs+bounces-908-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 831E5B351BE
	for <lists+linux-erofs@lfdr.de>; Tue, 26 Aug 2025 04:35:24 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4c9sG21mHbz3d3Z;
	Tue, 26 Aug 2025 12:35:22 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=210.51.61.247
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1756175722;
	cv=none; b=oXJGt2pYqw/KvXWxyFkFcdyU0N3Q+Yqb0IRMjXrSg6XOmuF7Stv7zsUB5aPlcX8DvNqa8MRsQeuuj72TpAUjxVQ0HhOifWb19nff5AC6Xrnw5wKlqbB0/j34oxR1T8gePD688GWFek7XYr3d/WTztiG1m5XcbtlqTzwDDUcHKIpMvx4HhgIx1T5z07FPJqH49NbYYRdsMZvt1VBRzj40i42O3IEw88cxA6W36dmyhkOIJHimEtN1E0ABZHpNeaJj37c6gAwzr7SPY6w304AitJsz+9IG3xvnJZQxnxbyQN1nJRZglqITKriuQLCw8qHXyP72Yb0qomxCr7Z2dkPJlw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1756175722; c=relaxed/relaxed;
	bh=FLnNFYK5TsWB2sZe+DrjsQehTdFLTWv19aPsaCY8BDY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=PhG/dqOJ+xD0Sgi1jrlH5qQh0dGPVzb0o2o77IfLD/F8m6gARfx7v8SKFkX1u/eUgLme3YFbmWv2wHy7opADpOm2Bir81Fdl9uyyizHXlepKAURR+zNZ2JSPPrftTom/tAKDEL7ZVi9/d1d6N5LnysG6zZ4AAOEfMiKyOcos9vEyZMw87epzCgvynNxc4j1okQ4wLxCywJd/V9Up4H2hDlSD/jIu9AqsxMq3ei1z1Kj7VWKjulACK8NG/7G3tNB6nXjyz4TZ6/RZuJ5Rz9ORBwizLkg6y8dXwIrhabeEs3RVuVr167Z/LLUDQ6l4iUxuln0XGVwz/a1FFuCEDPd2Jg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=inspur.com; spf=pass (client-ip=210.51.61.247; helo=ssh247.corpemail.net; envelope-from=liubo03@inspur.com; receiver=lists.ozlabs.org) smtp.mailfrom=inspur.com
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=inspur.com
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=inspur.com (client-ip=210.51.61.247; helo=ssh247.corpemail.net; envelope-from=liubo03@inspur.com; receiver=lists.ozlabs.org)
Received: from ssh247.corpemail.net (ssh247.corpemail.net [210.51.61.247])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4c9sG04PkTz3d3W
	for <linux-erofs@lists.ozlabs.org>; Tue, 26 Aug 2025 12:35:17 +1000 (AEST)
Received: from Jtjnmail201616.home.langchao.com
        by ssh247.corpemail.net ((D)) with ASMTP (SSL) id 202508261035075847;
        Tue, 26 Aug 2025 10:35:07 +0800
Received: from jtjnmail201625.home.langchao.com (10.100.2.35) by
 Jtjnmail201616.home.langchao.com (10.100.2.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.57; Tue, 26 Aug 2025 10:35:07 +0800
Received: from jtjnmail201622.home.langchao.com (10.100.2.22) by
 jtjnmail201625.home.langchao.com (10.100.2.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.57; Tue, 26 Aug 2025 10:35:06 +0800
Received: from jtjnmail201622.home.langchao.com ([fe80::15c3:8d74:3aa6:25f6])
 by jtjnmail201622.home.langchao.com ([fe80::15c3:8d74:3aa6:25f6%7]) with mapi
 id 15.01.2507.057; Tue, 26 Aug 2025 10:35:06 +0800
From: =?utf-8?B?Qm8gTGl1ICjliJjms6IpLea1qua9ruS/oeaBrw==?=
	<liubo03@inspur.com>
To: "hsiangkao@linux.alibaba.com" <hsiangkao@linux.alibaba.com>,
	"xiang@kernel.org" <xiang@kernel.org>, "chao@kernel.org" <chao@kernel.org>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-erofs@lists.ozlabs.org" <linux-erofs@lists.ozlabs.org>
Subject: Re: [PATCH] erofs: Add support for FS_IOC_GETFSLABEL
Thread-Topic: [PATCH] erofs: Add support for FS_IOC_GETFSLABEL
Thread-Index: AQHcFbi6Z9avxkNOEkmUEK8mQ5/cJrRzqx4AgACLdxA=
Date: Tue, 26 Aug 2025 02:35:06 +0000
Message-ID: <63904ade56634923ba734dcdab3c45d0@inspur.com>
References: <0bbd64f3599557766ff53c108794355026-8-25linux.alibaba.com@g.corp-email.com>
 <9251e366-06ea-405d-9980-e90c1a48aaaa@linux.alibaba.com>
In-Reply-To: <9251e366-06ea-405d-9980-e90c1a48aaaa@linux.alibaba.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator:
x-originating-ip: [182.45.253.56]
Content-Type: multipart/signed; micalg=SHA1;
	protocol="application/x-pkcs7-signature";
	boundary="----=_NextPart_000_0025_01DC1675.1629B8D0"
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
tUid: 20258261035072844308ecaa04445a43d29367e54b9ee
X-Abuse-Reports-To: service@corp-email.com
Abuse-Reports-To: service@corp-email.com
X-Complaints-To: service@corp-email.com
X-Report-Abuse-To: service@corp-email.com
X-Spam-Status: No, score=0.0 required=3.0 tests=RCVD_IN_MSPIKE_H5,
	RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=disabled
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org

------=_NextPart_000_0025_01DC1675.1629B8D0
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: 7bit

On 2025/8/26 10:09, Gao Xiang wrote:
>On 2025/8/25 20:06, Bo Liu wrote:
>> From: Bo Liu (OpenAnolis) <liubo03@inspur.com>
>>
>> Add support for reading to the erofs volume label from the
>> FS_IOC_GETFSLABEL ioctls.
>>
>> Signed-off-by: Bo Liu (OpenAnolis) <liubo03@inspur.com>
>> ---
>>   fs/erofs/Makefile   |  2 +-
>>   fs/erofs/data.c     |  4 ++++
>>   fs/erofs/dir.c      |  4 ++++
>>   fs/erofs/inode.c    |  2 +-
>>   fs/erofs/internal.h | 10 ++++++++++
>>   fs/erofs/ioctl.c    | 47
>+++++++++++++++++++++++++++++++++++++++++++++
>>   fs/erofs/super.c    |  2 ++
>>   fs/erofs/zdata.c    | 11 +++++++++++
>>   8 files changed, 80 insertions(+), 2 deletions(-)
>>   create mode 100644 fs/erofs/ioctl.c
>>
>> diff --git a/fs/erofs/Makefile b/fs/erofs/Makefile index
>> 549abc424763..5be6cc4acc1c 100644
>> --- a/fs/erofs/Makefile
>> +++ b/fs/erofs/Makefile
>> @@ -1,7 +1,7 @@
>>   # SPDX-License-Identifier: GPL-2.0-only
>>
>>   obj-$(CONFIG_EROFS_FS) += erofs.o
>> -erofs-objs := super.o inode.o data.o namei.o dir.o sysfs.o
>> +erofs-objs := super.o inode.o data.o namei.o dir.o sysfs.o ioctl.o
>>   erofs-$(CONFIG_EROFS_FS_XATTR) += xattr.o
>>   erofs-$(CONFIG_EROFS_FS_ZIP) += decompressor.o zmap.o zdata.o zutil.o
>>   erofs-$(CONFIG_EROFS_FS_ZIP_LZMA) += decompressor_lzma.o diff --git
>> a/fs/erofs/data.c b/fs/erofs/data.c index 3b1ba571c728..8ca29962a3dd
>> 100644
>> --- a/fs/erofs/data.c
>> +++ b/fs/erofs/data.c
>> @@ -475,6 +475,10 @@ static loff_t erofs_file_llseek(struct file *file, 
>> loff_t
>offset, int whence)
>>   const struct file_operations erofs_file_fops = {
>>   	.llseek		= erofs_file_llseek,
>>   	.read_iter	= erofs_file_read_iter,
>> +	.unlocked_ioctl = erofs_ioctl,
>> +#ifdef CONFIG_COMPAT
>> +	.compat_ioctl   = erofs_compat_ioctl,
>> +#endif
>>   	.mmap_prepare	= erofs_file_mmap_prepare,
>>   	.get_unmapped_area = thp_get_unmapped_area,
>>   	.splice_read	= filemap_splice_read,
>> diff --git a/fs/erofs/dir.c b/fs/erofs/dir.c index
>> debf469ad6bd..32b4f5aa60c9 100644
>> --- a/fs/erofs/dir.c
>> +++ b/fs/erofs/dir.c
>> @@ -123,4 +123,8 @@ const struct file_operations erofs_dir_fops = {
>>   	.llseek		= generic_file_llseek,
>>   	.read		= generic_read_dir,
>>   	.iterate_shared	= erofs_readdir,
>> +	.unlocked_ioctl = erofs_ioctl,
>> +#ifdef CONFIG_COMPAT
>> +	.compat_ioctl   = erofs_compat_ioctl,
>> +#endif
>>   };
>> diff --git a/fs/erofs/inode.c b/fs/erofs/inode.c index
>> 9a2f59721522..9248143e26df 100644
>> --- a/fs/erofs/inode.c
>> +++ b/fs/erofs/inode.c
>> @@ -214,7 +214,7 @@ static int erofs_fill_inode(struct inode *inode)
>>   	case S_IFREG:
>>   		inode->i_op = &erofs_generic_iops;
>>   		if (erofs_inode_is_data_compressed(vi->datalayout))
>> -			inode->i_fop = &generic_ro_fops;
>> +			inode->i_fop = &z_erofs_file_fops;
>
>Please also just use erofs_file_fops instead and adjust
>erofs_file_read_iter() for example.
>
>>   		else
>>   			inode->i_fop = &erofs_file_fops;
>>   		break;
>> diff --git a/fs/erofs/internal.h b/fs/erofs/internal.h index
>> 4ccc5f0ee8df..2f874b920c8b 100644
>> --- a/fs/erofs/internal.h
>> +++ b/fs/erofs/internal.h
>> @@ -32,6 +32,8 @@ __printf(2, 3) void _erofs_printk(struct super_block *sb,
>const char *fmt, ...);
>>   #define DBG_BUGON(x)            ((void)(x))
>>   #endif	/* !CONFIG_EROFS_FS_DEBUG */
>>
>> +#define EROFS_VOLUME_LABEL_LEN	16
>> +
>>   /* EROFS_SUPER_MAGIC_V1 to represent the whole file system */
>>   #define EROFS_SUPER_MAGIC   EROFS_SUPER_MAGIC_V1
>>
>> @@ -166,6 +168,9 @@ struct erofs_sb_info {
>>   	struct erofs_domain *domain;
>>   	char *fsid;
>>   	char *domain_id;
>> +
>> +	/* volume name */
>> +	u8 volume_label[EROFS_VOLUME_LABEL_LEN];
>
>	char *volume_name;
>
>>   };
>>
>>   #define EROFS_SB(sb) ((struct erofs_sb_info *)(sb)->s_fs_info) @@
>> -404,6 +409,7 @@ extern const struct inode_operations erofs_dir_iops;
>>
>>   extern const struct file_operations erofs_file_fops;
>>   extern const struct file_operations erofs_dir_fops;
>> +extern const struct file_operations z_erofs_file_fops;
>>
>>   extern const struct iomap_ops z_erofs_iomap_report_ops;
>>
>> @@ -535,6 +541,10 @@ static inline struct bio
>*erofs_fscache_bio_alloc(struct erofs_map_dev *mdev) {
>>   static inline void erofs_fscache_submit_bio(struct bio *bio) {}
>>   #endif
>>
>> +long erofs_ioctl(struct file *filp, unsigned int cmd, unsigned long
>> +arg); long erofs_compat_ioctl(struct file *filp, unsigned int cmd,
>> +			unsigned long arg);
>> +
>>   #define EFSCORRUPTED    EUCLEAN         /* Filesystem is corrupted
>*/
>>
>>   #endif	/* __EROFS_INTERNAL_H */
>> diff --git a/fs/erofs/ioctl.c b/fs/erofs/ioctl.c new file mode 100644
>> index 000000000000..10bfd593225f
>> --- /dev/null
>> +++ b/fs/erofs/ioctl.c
>> @@ -0,0 +1,47 @@
>> +// SPDX-License-Identifier: GPL-2.0-or-later #include <linux/fs.h>
>> +#include <linux/compat.h> #include <linux/file.h>
>> +
>> +#include "erofs_fs.h"
>> +#include "internal.h"
>> +
>> +static int erofs_ioctl_get_volume_label(struct inode *inode, void
>> +__user *arg) {
>> +	struct erofs_sb_info *sbi = EROFS_I_SB(inode);
>> +	size_t len;
>> +	int ret;
>> +	char label[EROFS_VOLUME_LABEL_LEN];
>> +
>> +	memcpy(label, sbi->volume_label, EROFS_VOLUME_LABEL_LEN);
>> +
>> +	len = strnlen(label, EROFS_VOLUME_LABEL_LEN);
>> +	if (len == EROFS_VOLUME_LABEL_LEN)
>> +		erofs_err(inode->i_sb, "label is too long, return the first %zu 
>> bytes",
>> +			  --len);
>
>No needed.
>
>> +
>> +	ret = copy_to_user(arg, label, len);
>
>
>	if (!sbi->volume_name)
>		ret = clear_user(arg, 1);
>	else
>		ret = copy_to_user(arg, sbi->volume_name,
>				   strlen(sbi->volume_name));
>	return ret ? -EFAULT : 0;
>
>...
>
>> +
>> +	return ret ? -EFAULT : 0;
>> +}
>> +
>> +long erofs_ioctl(struct file *filp, unsigned int cmd, unsigned long
>> +arg) {
>> +	struct inode *inode = file_inode(filp);
>> +	void __user *argp = (void __user *)arg;
>> +
>> +	switch (cmd) {
>> +	case FS_IOC_GETFSLABEL:
>> +		return erofs_ioctl_get_volume_label(inode, argp);
>> +	default:
>> +		return -ENOTTY;
>> +	}
>> +}
>> +
>> +#ifdef CONFIG_COMPAT
>> +long erofs_compat_ioctl(struct file *filp, unsigned int cmd,
>> +			unsigned long arg)
>> +{
>> +	return erofs_ioctl(filp, cmd, (unsigned long)compat_ptr(arg)); }
>> +#endif
>> diff --git a/fs/erofs/super.c b/fs/erofs/super.c index
>> 1b529ace4db0..e6ad6cf4ba82 100644
>> --- a/fs/erofs/super.c
>> +++ b/fs/erofs/super.c
>> @@ -343,6 +343,8 @@ static int erofs_read_superblock(struct super_block
>*sb)
>>   	sbi->fixed_nsec = le32_to_cpu(dsb->fixed_nsec);
>>   	super_set_uuid(sb, (void *)dsb->uuid, sizeof(dsb->uuid));
>>
>> +	memcpy(sbi->volume_label, dsb->volume_name,
>EROFS_VOLUME_LABEL_LEN);
>
>	if (dsb->volume_name[0]) {
>		sbi->volume_name = kstrndup(dsb->volume_name,
>dsb->volume_name, GFP_KERNEL);
>		if (!sbi->volume_name) {
>			...
>		}
>	}
>
>Need to kfree(sbi->volume_name) properly too.
>
>Thanks,
>Gao Xiang
>
>> +
>>   	/* parse on-disk compression configurations */
>>   	ret = z_erofs_parse_cfgs(sb, dsb);
>>   	if (ret < 0)
>> diff --git a/fs/erofs/zdata.c b/fs/erofs/zdata.c index
>> 2d73297003d2..b612bf7b2f08 100644
>> --- a/fs/erofs/zdata.c
>> +++ b/fs/erofs/zdata.c
>> @@ -1931,3 +1931,14 @@ const struct address_space_operations
>z_erofs_aops = {
>>   	.read_folio = z_erofs_read_folio,
>>   	.readahead = z_erofs_readahead,
>>   };
>> +
>> +const struct file_operations z_erofs_file_fops = {
>> +	.llseek		= generic_file_llseek,
>> +	.read_iter	= generic_file_read_iter,
>> +	.unlocked_ioctl	= erofs_ioctl,
>> +#ifdef CONFIG_COMPAT
>> +	.compat_ioctl	= erofs_compat_ioctl,
>> +#endif
>> +	.mmap		= generic_file_readonly_mmap,
>> +	.splice_read	= filemap_splice_read,
>> +};

Thanks for your comments.
I will send the next version of the patch later.

Thanks,
Bo Liu

------=_NextPart_000_0025_01DC1675.1629B8D0
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"

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
hkiG9w0DBzAdBgNVHQ4EFgQUsmXTjDrO/nhxGDpnz5cAr1neWI8wHwYDVR0jBBgwFoAUXlkDprRM
WGCRTvYetaU5pjLBNWowggEPBgNVHR8EggEGMIIBAjCB/6CB/KCB+YaBumxkYXA6Ly8vQ049SU5T
UFVSLUNBLENOPUpUQ0EyMDEyLENOPUNEUCxDTj1QdWJsaWMlMjBLZXklMjBTZXJ2aWNlcyxDTj1T
ZXJ2aWNlcyxDTj1Db25maWd1cmF0aW9uLERDPWhvbWUsREM9bGFuZ2NoYW8sREM9Y29tP2NlcnRp
ZmljYXRlUmV2b2NhdGlvbkxpc3Q/YmFzZT9vYmplY3RDbGFzcz1jUkxEaXN0cmlidXRpb25Qb2lu
dIY6aHR0cDovL0pUQ0EyMDEyLmhvbWUubGFuZ2NoYW8uY29tL0NlcnRFbnJvbGwvSU5TUFVSLUNB
LmNybDCCASwGCCsGAQUFBwEBBIIBHjCCARowgbEGCCsGAQUFBzAChoGkbGRhcDovLy9DTj1JTlNQ
VVItQ0EsQ049QUlBLENOPVB1YmxpYyUyMEtleSUyMFNlcnZpY2VzLENOPVNlcnZpY2VzLENOPUNv
bmZpZ3VyYXRpb24sREM9aG9tZSxEQz1sYW5nY2hhbyxEQz1jb20/Y0FDZXJ0aWZpY2F0ZT9iYXNl
P29iamVjdENsYXNzPWNlcnRpZmljYXRpb25BdXRob3JpdHkwZAYIKwYBBQUHMAKGWGh0dHA6Ly9K
VENBMjAxMi5ob21lLmxhbmdjaGFvLmNvbS9DZXJ0RW5yb2xsL0pUQ0EyMDEyLmhvbWUubGFuZ2No
YW8uY29tX0lOU1BVUi1DQSgxKS5jcnQwKQYDVR0lBCIwIAYIKwYBBQUHAwIGCCsGAQUFBwMEBgor
BgEEAYI3CgMEMDUGCSsGAQQBgjcVCgQoMCYwCgYIKwYBBQUHAwIwCgYIKwYBBQUHAwQwDAYKKwYB
BAGCNwoDBDBBBgNVHREEOjA4oCIGCisGAQQBgjcUAgOgFAwSbGl1Ym8wM0BpbnNwdXIuY29tgRJs
aXVibzAzQGluc3B1ci5jb20wUwYJKwYBBAGCNxkCBEYwRKBCBgorBgEEAYI3GQIBoDQEMlMtMS01
LTIxLTE2MDY5ODA4NDgtNzA2Njk5ODI2LTE4MDE2NzQ1MzEtMjU4ODUyMzQ4MA0GCSqGSIb3DQEB
CwUAA4IBAQAucjq5s0Qq1UtBIL8Und9mnrfn3azil+rXBoZf/N+DNuZYml+Ct4SDC0tng7F5kSt/
2zU4vShrkviUh8kjCstCrPyqkxQodvm7reuGuBKZLy9PLZR0oB3S7vD9gUdMCw7UianFwY+mgbG/
33dY43zujZIY8DMm6od3GMZlIueeqB6VyEESU4+ll2VFPyLXPzUMBK7DLAEnOiPbJSUvR7738lSk
DPXxdujcFhL9wxTvh/3ghYuY0OCwf+HM7TFBSSFxa1wdkfO8aA9Bl6tY5awZ6bbsr+3+FRf/h1jW
ZQOCCnEGixEPN0irb1ZjdI2O4u1TlTwZAYXdLVRqmr2vi1KHMYIDkzCCA48CAQEwcDBZMRMwEQYK
CZImiZPyLGQBGRYDY29tMRgwFgYKCZImiZPyLGQBGRYIbGFuZ2NoYW8xFDASBgoJkiaJk/IsZAEZ
FgRob21lMRIwEAYDVQQDEwlJTlNQVVItQ0ECE34AA47lMgPE5azBUewAAQADjuUwCQYFKw4DAhoF
AKCCAfgwGAYJKoZIhvcNAQkDMQsGCSqGSIb3DQEHATAcBgkqhkiG9w0BCQUxDxcNMjUwODI2MDIz
NTA1WjAjBgkqhkiG9w0BCQQxFgQUDwIOCCY9OZSsUWIaWS8URKSiOJ4wfwYJKwYBBAGCNxAEMXIw
cDBZMRMwEQYKCZImiZPyLGQBGRYDY29tMRgwFgYKCZImiZPyLGQBGRYIbGFuZ2NoYW8xFDASBgoJ
kiaJk/IsZAEZFgRob21lMRIwEAYDVQQDEwlJTlNQVVItQ0ECE34AA47lMgPE5azBUewAAQADjuUw
gYEGCyqGSIb3DQEJEAILMXKgcDBZMRMwEQYKCZImiZPyLGQBGRYDY29tMRgwFgYKCZImiZPyLGQB
GRYIbGFuZ2NoYW8xFDASBgoJkiaJk/IsZAEZFgRob21lMRIwEAYDVQQDEwlJTlNQVVItQ0ECE34A
A47lMgPE5azBUewAAQADjuUwgZMGCSqGSIb3DQEJDzGBhTCBgjAKBggqhkiG9w0DBzALBglghkgB
ZQMEASowCwYJYIZIAWUDBAEWMAsGCWCGSAFlAwQBAjAOBggqhkiG9w0DAgICAIAwDQYIKoZIhvcN
AwICAUAwBwYFKw4DAhowCwYJYIZIAWUDBAIDMAsGCWCGSAFlAwQCAjALBglghkgBZQMEAgEwDQYJ
KoZIhvcNAQEBBQAEggEAfXx5hvkorxT41ARaaNXEcyKRuNapQN/1LjlIMjSsLM3Ccl88RXkBoGDS
cjzIGiwTLqvSGO2Jvx1GJGgNB+MnVAwygDDoRyRo4B8kZSMGGFR8U3YQLRonSb9Kfeai6Hp2vWdH
RtyDyUihuhBpv5WLs47mJs9S7RN1ooQJamd0FzAVrPmnH71AfDDO0RQ1nwOg34XKqUVDRbQtfoa2
tXuJdvAAKSBpTXKyqBNvUmB51qFTBlYVq9ocz9DwcN7w4vUzbC/Wy1jjPzePI8Zvt5qYGyNVyMmU
Dl/xisx70zs3Pjq9538B5nwFUVI7mPfLuvNG5ntWfa+FYWK/MShuJ3Uz6QAAAAAAAA==

------=_NextPart_000_0025_01DC1675.1629B8D0--

