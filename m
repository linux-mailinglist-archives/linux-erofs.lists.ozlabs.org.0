Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 891EF43C98D
	for <lists+linux-erofs@lfdr.de>; Wed, 27 Oct 2021 14:23:48 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4HfSXf2qGDz2yPW
	for <lists+linux-erofs@lfdr.de>; Wed, 27 Oct 2021 23:23:46 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.57;
 helo=out30-57.freemail.mail.aliyun.com;
 envelope-from=hsiangkao@linux.alibaba.com; receiver=<UNKNOWN>)
Received: from out30-57.freemail.mail.aliyun.com
 (out30-57.freemail.mail.aliyun.com [115.124.30.57])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4HfSXZ49B5z2yHH
 for <linux-erofs@lists.ozlabs.org>; Wed, 27 Oct 2021 23:23:40 +1100 (AEDT)
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R191e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=e01e04400; MF=hsiangkao@linux.alibaba.com;
 NM=1; PH=DS; RN=6; SR=0; TI=SMTPD_---0UtuBzO2_1635337402; 
Received: from B-P7TQMD6M-0146.local(mailfrom:hsiangkao@linux.alibaba.com
 fp:SMTPD_---0UtuBzO2_1635337402) by smtp.aliyun-inc.com(127.0.0.1);
 Wed, 27 Oct 2021 20:23:24 +0800
Date: Wed, 27 Oct 2021 20:23:22 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: Guo Xuenan <guoxuenan@huawei.com>
Subject: Re: [PATCH 2/3] erofs-utils: dump: add -i options to dump file
 information of specific inode number
Message-ID: <YXlEuu6Gqq/wXXX+@B-P7TQMD6M-0146.local>
References: <20211027120351.2885966-1-guoxuenan@huawei.com>
 <20211027120351.2885966-2-guoxuenan@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20211027120351.2885966-2-guoxuenan@huawei.com>
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
Cc: daeho43@gmail.com, linux-erofs@lists.ozlabs.org, mpiglet@outlook.com
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On Wed, Oct 27, 2021 at 08:03:50PM +0800, Guo Xuenan wrote:
> From: Wang Qi <mpiglet@outlook.com>
> 
> Signed-off-by: Guo Xuenan <guoxuenan@huawei.com>
> Signed-off-by: Wang Qi <mpiglet@outlook.com>
> ---
>  dump/main.c | 135 +++++++++++++++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 134 insertions(+), 1 deletion(-)
> 
> diff --git a/dump/main.c b/dump/main.c
> index 98ee68b..8a31345 100644
> --- a/dump/main.c
> +++ b/dump/main.c
> @@ -17,8 +17,10 @@
>  
>  struct erofsdump_cfg {
>  	unsigned int totalshow;
> +	bool show_inode;
>  	bool show_superblock;
>  	bool show_statistics;
> +	u64 ino;

erofs_nid_t nid;

>  };
>  static struct erofsdump_cfg dumpcfg;
>  
> @@ -82,6 +84,9 @@ static struct erofsdump_feature feature_lists[] = {
>  };
>  
>  static int erofs_read_dir(erofs_nid_t nid, erofs_nid_t parent_nid);
> +static inline int erofs_checkdirent(struct erofs_dirent *de,
> +		struct erofs_dirent *last_de,
> +		u32 maxsize, const char *dname);
>  
>  static void usage(void)
>  {
> @@ -89,6 +94,7 @@ static void usage(void)
>  	      "Dump erofs layout from IMAGE, and [options] are:\n"
>  	      " -S      show statistic information of the image\n"
>  	      " -V      print the version number of dump.erofs and exit.\n"
> +	      " -i #    show the target inode info of nid #\n"
>  	      " -s      show information about superblock\n"
>  	      " --help  display this help and exit.\n",
>  	      stderr);
> @@ -102,10 +108,17 @@ static void erofsdump_print_version(void)
>  static int erofsdump_parse_options_cfg(int argc, char **argv)
>  {
>  	int opt;
> +	u64 i;

erofs_nid_t i;

>  
> -	while ((opt = getopt_long(argc, argv, "SVs",
> +	while ((opt = getopt_long(argc, argv, "SVi:s",
>  				  long_options, NULL)) != -1) {
>  		switch (opt) {
> +		case 'i':

I perfer "--nid" for this, since the inode number is actually the field
in the on-disk inode (Although we report nid for now.)

> +			i = atoll(optarg);
> +			dumpcfg.show_inode = true;
> +			dumpcfg.ino = i;
> +			++dumpcfg.totalshow;
> +			break;
>  		case 's':
>  			dumpcfg.show_superblock = true;
>  			++dumpcfg.totalshow;
> @@ -331,6 +344,123 @@ static int erofs_read_dir(erofs_nid_t nid, erofs_nid_t parent_nid)
>  	return 0;
>  }
>  
> +static int erofs_get_pathname(erofs_nid_t nid, erofs_nid_t parent_nid,
> +		erofs_nid_t target, char *path, unsigned int pos)
> +{
> +	int err;
> +	struct erofs_inode inode = {.nid = nid};
> +	erofs_off_t offset;
> +	char buf[EROFS_BLKSIZ];
> +
> +	path[pos++] = '/';
> +	if (target == sbi.root_nid)
> +		return 0;
> +
> +	err = erofs_read_inode_from_disk(&inode);
> +	if (err) {
> +		erofs_err("read inode %lu failed", nid);
> +		return err;
> +	}
> +
> +	offset = 0;
> +	while (offset < inode.i_size) {
> +		erofs_off_t maxsize = min_t(erofs_off_t,
> +					inode.i_size - offset, EROFS_BLKSIZ);
> +		struct erofs_dirent *de = (void *)buf;
> +		struct erofs_dirent *end;
> +		unsigned int nameoff;
> +
> +		err = erofs_pread(&inode, buf, maxsize, offset);
> +		if (err)
> +			return err;
> +
> +		nameoff = le16_to_cpu(de->nameoff);
> +		end = (void *)buf + nameoff;
> +		while (de < end) {
> +			const char *dname;
> +			int len;
> +
> +			nameoff = le16_to_cpu(de->nameoff);
> +			dname = (char *)buf + nameoff;
> +			len = erofs_checkdirent(de, end, maxsize, dname);
> +			if (len < 0)
> +				return len;
> +
> +			if (de->nid == target) {
> +				memcpy(path + pos, dname, len);
> +				return 0;
> +			}
> +
> +			if (de->file_type == EROFS_FT_DIR &&
> +					de->nid != parent_nid &&
> +					de->nid != nid) {
> +				memcpy(path + pos, dname, len);
> +				err = erofs_get_pathname(de->nid, nid,
> +						target, path, pos + len);
> +				if (!err)
> +					return 0;
> +				memset(path + pos, 0, len);
> +			}
> +			++de;
> +		}
> +		offset += maxsize;
> +	}
> +	return -1;
> +}
> +
> +static void dumpfs_print_inode(void)
> +{
> +	int err;
> +	erofs_off_t size;
> +	u16 access_mode;
> +	time_t t;
> +	erofs_nid_t nid = dumpcfg.ino;
> +	struct erofs_inode inode = {.nid = nid};
> +	char path[PATH_MAX + 1] = {0};
> +	char access_mode_str[] = "rwxrwxrwx";
> +	char timebuf[128] = {0};
> +
> +	err = erofs_read_inode_from_disk(&inode);
> +	if (err) {
> +		erofs_err("read inode %lu from disk failed", nid);
> +		return;
> +	}
> +
> +	err = erofs_get_occupied_size(&inode, &size);
> +	if (err) {
> +		erofs_err("get file size failed\n");
> +		return;
> +	}
> +
> +	err = erofs_get_pathname(sbi.root_nid, sbi.root_nid, nid, path, 0);
> +	if (err < 0) {
> +		fprintf(stderr, "File: Path not found.\n");
> +		return;
> +	}
> +
> +	fprintf(stdout, "File : %s\n", path);
> +	fprintf(stdout, "Inode: %lu  ", inode.nid);
> +	fprintf(stdout, "Links: %u  ", inode.i_nlink);
> +	fprintf(stdout, "Layout: %d\n", inode.datalayout);
> +	fprintf(stdout, "File size: %lu   ", inode.i_size);
> +	fprintf(stdout,	"On-disk size: %lu   ", size);
> +	fprintf(stdout, "Compress rate: %.2f%%\n",
> +			(double)(100 * size) / (double)(inode.i_size));
> +	fprintf(stdout, "Inode size: %d   ", inode.inode_isize);
> +	fprintf(stdout, "Extent size: %u   ", inode.extent_isize);
> +	fprintf(stdout,	"Xattr size: %u\n", inode.xattr_isize);
> +	access_mode = inode.i_mode & 0777;
> +	t = inode.i_ctime;

Only extented inodes have their own timestamps.

> +	strftime(timebuf, sizeof(timebuf),
> +			"%Y-%m-%d %H:%M:%S", localtime(&t));

place
	access_mode = inode.i_mode & 0777;

here.

> +	for (int i = 8; i >= 0; i--)
> +		if (((access_mode >> i) & 1) == 0)
> +			access_mode_str[8 - i] = '-';
> +	fprintf(stdout, "Uid: %u   Gid: %u  ", inode.i_uid, inode.i_gid);
> +	fprintf(stdout, "Access: %04o/%s\n", access_mode, access_mode_str);
> +	fprintf(stdout, "Birth : %s\n", timebuf);

"Timestamp :" here is preferred.

Thanks,
Gao Xiang

> +}
> +
>  static void erofsdump_print_chart_row(char *col1, unsigned int col2,
>  		double col3, char *col4)
>  {
> @@ -512,6 +642,9 @@ int main(int argc, char **argv)
>  	if (dumpcfg.show_statistics)
>  		erofsdump_print_statistic();
>  
> +	if (dumpcfg.show_inode)
> +		dumpfs_print_inode();
> +
>  exit:
>  	erofs_exit_configure();
>  	return err;
> -- 
> 2.31.1
