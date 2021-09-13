Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id E37CF408B49
	for <lists+linux-erofs@lfdr.de>; Mon, 13 Sep 2021 14:47:22 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4H7R884C03z2xr8
	for <lists+linux-erofs@lfdr.de>; Mon, 13 Sep 2021 22:47:20 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.44;
 helo=out30-44.freemail.mail.aliyun.com;
 envelope-from=hsiangkao@linux.alibaba.com; receiver=<UNKNOWN>)
Received: from out30-44.freemail.mail.aliyun.com
 (out30-44.freemail.mail.aliyun.com [115.124.30.44])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4H7R812rkTz2xr8
 for <linux-erofs@lists.ozlabs.org>; Mon, 13 Sep 2021 22:47:08 +1000 (AEST)
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R751e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=e01e04426; MF=hsiangkao@linux.alibaba.com;
 NM=1; PH=DS; RN=5; SR=0; TI=SMTPD_---0UoG-2k0_1631537211; 
Received: from B-P7TQMD6M-0146.local(mailfrom:hsiangkao@linux.alibaba.com
 fp:SMTPD_---0UoG-2k0_1631537211) by smtp.aliyun-inc.com(127.0.0.1);
 Mon, 13 Sep 2021 20:46:52 +0800
Date: Mon, 13 Sep 2021 20:46:51 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: Huang Jianan <huangjianan@oppo.com>
Subject: Re: [PATCH v1 3/5] dump.erofs: add -S options for collecting
 statistics of the whole filesystem
Message-ID: <YT9IO9mZpVRkjPnd@B-P7TQMD6M-0146.local>
References: <20210911134635.1253426-1-guoxuenan@huawei.com>
 <20210911134635.1253426-3-guoxuenan@huawei.com>
 <20210911161305.GC3160@hsiangkao-HP-ZHAN-66-Pro-G1>
 <7790736c-0aeb-ca52-af44-cc72e168ed0f@oppo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <7790736c-0aeb-ca52-af44-cc72e168ed0f@oppo.com>
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
Cc: linux-erofs@lists.ozlabs.org, mpiglet@outlook.com
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On Mon, Sep 13, 2021 at 12:30:04PM +0800, Huang Jianan wrote:
> 在 2021/9/12 0:13, Gao Xiang 写道:
> > (+Cc Jianan.)
> > 
> > On Sat, Sep 11, 2021 at 09:46:33PM +0800, Guo Xuenan wrote:
> > > From: mpiglet <mpiglet@outlook.com>
> > > 
> > > Signed-off-by: Guo Xuenan <guoxuenan@huawei.com>
> > > Signed-off-by: mpiglet <mpiglet@outlook.com>
> > > ---
> > >   dump/main.c | 474 ++++++++++++++++++++++++++++++++++++++++++++++++++++
> > >   1 file changed, 474 insertions(+)
> > > 
> > > diff --git a/dump/main.c b/dump/main.c
> > > index 25ac89f..b0acc0b 100644
> > > --- a/dump/main.c
> > > +++ b/dump/main.c
> > > @@ -19,10 +19,78 @@
> > >   struct dumpcfg {
> > >   	bool print_superblock;
> > > +	bool print_statistic;
> > >   	bool print_version;
> > >   };
> > >   static struct dumpcfg dumpcfg;
> > > +static const char chart_format[] = "%-16s	%-11d %8.2f%% |%-50s|\n";
> > > +static const char header_format[] = "%-16s %11s %16s |%-50s|\n";
> > > +static char *file_types[] = {
> > > +	".so",
> > > +	".png",
> > > +	".jpg",
> > > +	".xml",
> > > +	".html",
> > > +	".odex",
> > > +	".vdex",
> > > +	".apk",
> > > +	".ttf",
> > > +	".jar",
> > > +	".json",
> > > +	".ogg",
> > > +	".oat",
> > > +	".art",
> > > +	".rc",
> > > +	".otf",
> > > +	".txt",
> > > +	"others",
> > > +};
> > > +enum {
> > > +	SOFILETYPE = 0,
> > > +	PNGFILETYPE,
> > > +	JPEGFILETYPE,
> > > +	XMLFILETYPE,
> > > +	HTMLFILETYPE,
> > > +	ODEXFILETYPE,
> > > +	VDEXFILETYPE,
> > > +	APKFILETYPE,
> > > +	TTFFILETYPE,
> > > +	JARFILETYPE,
> > > +	JSONFILETYPE,
> > > +	OGGFILETYPE,
> > > +	OATFILETYPE,
> > > +	ARTFILETYPE,
> > > +	RCFILETYPE,
> > > +	OTFFILETYPE,
> > > +	TXTFILETYPE,
> > > +	OTHERFILETYPE,
> > > +};
> > Why we need enums here? Can these be resolved with some array index?
> > 
> > > +
> > > +#define	FILE_SIZE_BITS	30
> > > +struct statistics {
> > > +	unsigned long blocks;
> > > +	unsigned long files;
> > > +	unsigned long files_total_size;
> > > +	unsigned long files_total_origin_size;
> > > +	double compress_rate;
> > > +	unsigned long compressed_files;
> > > +	unsigned long uncompressed_files;
> > > +
> > > +	unsigned long regular_files;
> > > +	unsigned long dir_files;
> > > +	unsigned long chardev_files;
> > > +	unsigned long blkdev_files;
> > > +	unsigned long fifo_files;
> > > +	unsigned long sock_files;
> > > +	unsigned long symlink_files;
> > > +
> > > +	unsigned int file_type_stat[OTHERFILETYPE + 1];
> > > +	unsigned int file_org_size[FILE_SIZE_BITS];
> > What do "FILE_SIZE_BITS" and "file_org_size" mean?
> > 
> > > +	unsigned int file_comp_size[FILE_SIZE_BITS];
> > > +};
> > > +static struct statistics stats;
> > > +
> > >   static struct option long_options[] = {
> > >   	{"help", no_argument, 0, 1},
> > >   	{0, 0, 0, 0},
> > > @@ -33,6 +101,7 @@ static void usage(void)
> > >   	fputs("usage: [options] erofs-image \n\n"
> > >   		"Dump erofs layout from erofs-image, and [options] are:\n"
> > >   		"-s          print information about superblock\n"
> > > +		"-S      print statistic information of the erofs-image\n"
> > >   		"-v/-V      print dump.erofs version info\n"
> > >   		"-h/--help  display this help and exit\n", stderr);
> > >   }
> > > @@ -51,6 +120,9 @@ static int dumpfs_parse_options_cfg(int argc, char **argv)
> > >   		case 's':
> > >   			dumpcfg.print_superblock = true;
> > >   			break;
> > > +		case 'S':
> > > +			dumpcfg.print_statistic = true;
> > > +			break;
> > >   		case 'v':
> > >   		case 'V':
> > >   			dumpfs_print_version();
> > > @@ -78,6 +150,116 @@ static int dumpfs_parse_options_cfg(int argc, char **argv)
> > >   	return 0;
> > >   }
> > > +static int z_erofs_get_last_cluster_size_from_disk(struct erofs_map_blocks *map,
> > > +		erofs_off_t last_cluster_size,
> > > +		erofs_off_t *last_cluster_compressed_size)
> > Hmmm... do we really need the exact compressed bytes?
> > or just compressed blocks is enough?
> > 
> > "compressed blocks" can be gotten in erofs inode.
> > 
> > Btw, although I think it's useful for fsck (check if an erofs is correct).
> > 
> > > +{
> > > +	int ret;
> > > +	int decomp_len;
> > > +	int compressed_len = 0;
> > > +	char *decompress;
> > > +	char raw[Z_EROFS_PCLUSTER_MAX_SIZE] = {0};
> > > +
> > > +	ret = dev_read(raw, map->m_pa, map->m_plen);
> > > +	if (ret < 0)
> > > +		return -EIO;
> > > +
> > > +	if (erofs_sb_has_lz4_0padding()) {
> > > +		compressed_len = map->m_plen;
> > > +	} else {
> > > +		// lz4 maximum compression ratio is 255
> > > +		decompress = (char *)malloc(map->m_plen * 255);
> > > +		if (!decompress) {
> > > +			erofs_err("allocate memory for decompress space failed");
> > > +			return -1;
> > > +		}
> > > +		decomp_len = LZ4_decompress_safe_partial(raw, decompress,
> > > +				map->m_plen, last_cluster_size,
> > > +				map->m_plen * 10);
> > > +		if (decomp_len < 0) {
> > > +			erofs_err("decompress last cluster to get decompressed size failed");
> > > +			free(decompress);
> > > +			return -1;
> > > +		}
> > > +		compressed_len = LZ4_compress_destSize(decompress, raw,
> > > +				&decomp_len, Z_EROFS_PCLUSTER_MAX_SIZE);
> > > +		if (compressed_len < 0) {
> > > +			erofs_err("compress to get last extent size failed\n");
> > > +			free(decompress);
> > > +			return -1;
> > > +		}
> > > +		free(decompress);
> > > +		// dut to the use of lz4hc (can use different compress level),
> > > +		// our normal lz4 compress result may be bigger
> > > +		compressed_len = compressed_len < map->m_plen ?
> > > +			compressed_len : map->m_plen;
> > > +	}
> > > +
> > > +	*last_cluster_compressed_size = compressed_len;
> > > +	return 0;
> > > +}
> > > +
> > > +static int z_erofs_get_compressed_size(struct erofs_inode *inode,
> > > +		erofs_off_t *size)
> > > +{
> > > +	int err;
> > > +	erofs_blk_t compressedlcs;
> > > +	erofs_off_t last_cluster_size;
> > > +	erofs_off_t last_cluster_compressed_size;
> > > +	struct erofs_map_blocks map = {
> > > +		.index = UINT_MAX,
> > > +		.m_la = inode->i_size - 1,
> > > +	};
> > > +
> > > +	err = z_erofs_map_blocks_iter(inode, &map);
> > (add Jianan here.)
> > 
> > Can we port the latest erofs kernel fiemap code to erofs-utils, and add
> > some functionality to get the file distribution as well when the fs isn't
> > mounted?
> Hi Xiang,
> 
> I have sent the patch and verified it with a similar function. Better to use
> the
> new interface here.

Yeah, thanks for the patch:
https://lore.kernel.org/linux-erofs/20210913042716.17529-1-huangjianan@oppo.com/

Hopefully Xuenan could base on this work.

Thanks,
Gao XIang

> 
> Thanks,
> Jianan
