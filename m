Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CCFD6F151
	for <lists+linux-erofs@lfdr.de>; Sun, 21 Jul 2019 05:09:16 +0200 (CEST)
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 45rqTK469vzDqgV
	for <lists+linux-erofs@lfdr.de>; Sun, 21 Jul 2019 13:09:09 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.ozlabs.org;
	s=201707; t=1563678549;
	bh=RKKTEoqMfM2/17axBVyHgR0OBtky4kBIBIgSujubTJE=;
	h=Subject:To:References:Date:In-Reply-To:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:Cc:
	 From;
	b=gEpgC2KNwtO8ZCKtu0MHE4sqHBtSnB/+utEtItcn7J8cx6a4H54BDfzn7CQgNISwE
	 IT8zldEDaj9Feq7QlI4/WWZEktOHvbw9dAIBo8oqkgKDeeMm/A62MpDS+g3cNPycAm
	 q1JssqDqSfMT1hy1TtoBskd/3iiNWGrInwT1UmEmUO0rRaIfyM2C3+3J7cr+gaHlJn
	 BUL5Es/0BVQ2jHovih3dS/ZBJpGLyqtJV055faoU6IbEXUO5uQivHfA6tPxdFhgMFO
	 xxi/21wnUbT05vBBLeU9ZfiRtA1s0AHq58RVDLxakVNU2A8EGGc9uBPoweIK8xvr23
	 HcM5I39Xd7Few==
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=aol.com
 (client-ip=98.137.64.204; helo=sonic303-23.consmr.mail.gq1.yahoo.com;
 envelope-from=hsiangkao@aol.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=reject dis=none) header.from=aol.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=aol.com header.i=@aol.com header.b="LxKJfe5W"; 
 dkim-atps=neutral
Received: from sonic303-23.consmr.mail.gq1.yahoo.com
 (sonic303-23.consmr.mail.gq1.yahoo.com [98.137.64.204])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 45rqT82Cs9zDqg9
 for <linux-erofs@lists.ozlabs.org>; Sun, 21 Jul 2019 13:08:57 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aol.com; s=a2048;
 t=1563678532; bh=vVFM2sBPFsjLdmREx6J7nhmZg0MP4oRcc3xKMjhhJYA=;
 h=Subject:To:Cc:References:From:Date:In-Reply-To:From:Subject;
 b=LxKJfe5WG40iGzUlOwIt9upXjpI5Ro+j9vn6bNlHPJPMd1KXwFxoulbrYMHZ/WUZGbriu+87wSLgn1dBW1Os6PndEIomOR7oBMFCimAEPDgwhc2LqMvkOpp49TBAG6WHL0rC9KSgoBE9tJSBmW1DTs0usIAzrlqVv1GBYE/mk4409ifYeOpzv1vF7ol8Q0OBbJHHK7bkq0b66XkboIXI5wZgt3mVSGcm37zRH7nPpl+0EJs3xYM8ViDwQPM23DORxLWxfOUG/CjHx91CBuneNcuw4Dcs7p/7b137H4rzNFJ7QAflLeSZo016uhgNTdhs9DrmAXdi4/OFoIaTPtwhmA==
X-YMail-OSG: KejkysgVM1kkAjE.MTml_hOsTU_a7UxB0SmXeXQ5gjWo3lEpWY9krPhzzXHpN4F
 aiy7pHcX3FWPA1UfpNyB4b9E_ASexfTYZuQlbAfDhMWpoz4oEaFTzmYiO9zFubxqAZQEgVwK_cSo
 mqkDeT.haov64Ky7lCtyOPYPCJpenWOzekg.jiDIzzp1cYGb8p164kwFBMvShQlsLWQNyu9pU8kq
 WPsia2MxxqaT3a8PjOjUIB3mWCHCY2XUILuPhLeppDdRZSUCFlm8Q7Di3a8sE0c_ObEngYeZNoce
 Aio38D0jpxgdicS_Rs2yGbo8nS5ulOZgsCAL9D96S9d4PvdPuY5aAd5t55hE3GPqrZzwiS6u8MtP
 ZR8MIvxURY.cMLU8hYU4F_jYZrayIwUZ3bmx_pcfMArOGAXm3jfGHC8Z5m.HHYuV3giD.19z6MdJ
 BAZDAZ.FMR8y1nTgcm0naZz6oar9ieylSENnVpf27nyzc.At5bsJro_eeTZUMRpsUu7Rq4hvjrZL
 0d_EE9ldUd36IhUFBpg3qTp7EzRMaZ0UKUKuj_EHayM_Ub2R9bJhE3VypT8_eHaRBT2xdZcIFGjv
 mYxX..F2AJ_aTYza5kWiYwnJfegxMJFUmwmlHwGUczR1Ll.Poergp6OxuE_RJmfsWzlrDi1pctUc
 NGEZcAR3ap3pdmQBSkwjwyM.lI4WVDo.M6Mhcj64WvANk6_nC31D_6yZ2Ab1.oqehqu9fODoRhlc
 fu2W7zkIvDcLVxduywW0sSoHkneM6SaWljh.mQL1zoFWJ4Ap64xdqSVX0Kj2zNwk80eoF0vDSTyF
 asKj4rAH9KpRLa3eLy2KGNHrPQj8shdSOfYKkm7J6hLXvQu5EIUAhtkgz2uIzw.s_7I8XU2TQhUM
 EnRRMPt8ND_Xz7dSNx2ULhFG0eQVjx0tWSIg32V6XLy8aJ6deMsMqebT79BrjyqD27UYLUc2Onqa
 AWnT_cLdbzvr.0BQGAPdg1.yfemWR2kwWagOtU7rEfx1HiKibfrMlGpbzmb9j_PNw1D3qh3p.9us
 RqqH0VewpVq1OZwukg5I7EvMGO39tfDryH0IwmUNYkloOFCn8yedom_S1ajJ3mN6_M_a.JT4WIn2
 4Do6NgGlMk8HoBBlbI59aiyT.DMU2N_MhYQYRR7r3PXdbTjCwq3e9OrorTkuvFoyY6N27ENPf2c2
 YJkRMIl4qaWju5CVFZKdOgwnttgAgxl4wySW4RXwRSK5DQeve09r8rg--
Received: from sonic.gate.mail.ne1.yahoo.com by
 sonic303.consmr.mail.gq1.yahoo.com with HTTP; Sun, 21 Jul 2019 03:08:52 +0000
Received: by smtp416.mail.gq1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA
 ID e21bc386e5ef1cd902fdfa033303b546; 
 Sun, 21 Jul 2019 03:08:48 +0000 (UTC)
Subject: Re: [PATCH v2 03/24] erofs: add super block operations
To: Al Viro <viro@zeniv.linux.org.uk>, Gao Xiang <gaoxiang25@huawei.com>
References: <20190711145755.33908-1-gaoxiang25@huawei.com>
 <20190711145755.33908-4-gaoxiang25@huawei.com>
 <20190720224955.GD17978@ZenIV.linux.org.uk>
Message-ID: <161cffc4-1d61-5dc6-45df-f1779ef03b0f@aol.com>
Date: Sun, 21 Jul 2019 11:08:42 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190720224955.GD17978@ZenIV.linux.org.uk>
Content-Type: text/plain; charset=gbk
Content-Transfer-Encoding: 8bit
Content-Language: en-US
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
From: Gao Xiang via Linux-erofs <linux-erofs@lists.ozlabs.org>
Reply-To: Gao Xiang <hsiangkao@aol.com>
Cc: devel@driverdev.osuosl.org, Theodore Ts'o <tytso@mit.edu>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-erofs@lists.ozlabs.org,
 LKML <linux-kernel@vger.kernel.org>,
 Linus Torvalds <torvalds@linux-foundation.org>, linux-fsdevel@vger.kernel.org,
 Andrew Morton <akpm@linux-foundation.org>, Miao Xie <miaoxie@huawei.com>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Hi Al,

On 2019/7/21 ????6:49, Al Viro wrote:
> On Thu, Jul 11, 2019 at 10:57:34PM +0800, Gao Xiang wrote:
>> This commit adds erofs super block operations, including (u)mount,
>> remount_fs, show_options, statfs, in addition to some private
>> icache management functions.
> Could you explain what's the point of this
>
>> +	/* save the device name to sbi */
>> +	sbi->dev_name = __getname();
>> +	if (!sbi->dev_name) {
>> +		err = -ENOMEM;
>> +		goto err_devname;
>> +	}
>> +
>> +	snprintf(sbi->dev_name, PATH_MAX, "%s", dev_name);
>> +	sbi->dev_name[PATH_MAX - 1] = '\0';
> ... and this?

Thanks for your kindly reply...

Yes, I remember the above code you already mentioned months ago... The
detail is that

It is for debugging use as you said below, mainly for our internal
testers whose jobs are
to read kmsg logs and catch kernel problems. sb->s_id (device number)
maybe not
straight-forward for them compared with dev_name...

The initial purpose of erofs_mount_private was to passing multi private
data from erofs_mount
to erofs_read_super, which was written before fs_contest was introduced.

I agree with you, it seems better to just use s_id in community and
delete erofs_mount_private stuffs...
Yet I don't look into how to use new fs_context, could I keep using
legacy mount interface and fix them all?


>
>> +struct erofs_mount_private {
>> +	const char *dev_name;
>> +	char *options;
>> +};
>> +
>> +/* support mount_bdev() with options */
>> +static int erofs_fill_super(struct super_block *sb,
>> +			    void *_priv, int silent)
>> +{
>> +	struct erofs_mount_private *priv = _priv;
>> +
>> +	return erofs_read_super(sb, priv->dev_name,
>> +		priv->options, silent);
>> +}
>> +
>> +static struct dentry *erofs_mount(
>> +	struct file_system_type *fs_type, int flags,
>> +	const char *dev_name, void *data)
>> +{
>> +	struct erofs_mount_private priv = {
>> +		.dev_name = dev_name,
>> +		.options = data
>> +	};
>> +
>> +	return mount_bdev(fs_type, flags, dev_name,
>> +		&priv, erofs_fill_super);
>> +}
> AFAICS, the only use of sbi->dev_name is debugging printks and
> all of those have sb->s_id available, with device name stored
> in there.  Which makes the whole thing bloody weird - what's
> wrong with simply passing data to mount_bdev (instead of
> &priv), folding erofs_read_super() into erofs_fill_super(),
> replacing sbi->dev_name with sb->s_id and killing sbi->dev_name,
> along with the associated allocation, freeing, handling of
> allocation failure, etc.?


OK, make sense. I will do...


>
> For drivers/staging location that would be (compile-tested only)
> the diff below.  I suspect that you could simplify fill_super
> a bit further if you added ->kill_sb() along the lines of
>
> 	sbi = EROFS(sb);
> #ifdef EROFS_FS_HAS_MANAGED_CACHE
> 	if (sbi && !sb->s_root)
> 		iput(sbi->managed_cache);
> #endif
> 	kill_block_super(sb);
> 	kfree(sbi);
> and took freeing sbi out of your ->put_super().  Then fill_super()
> would simply return -E... on all failure exits, leaving all cleanup
> to ->kill_sb().  E.g. initialization of the same ->managed_cache
> would become
> #ifdef EROFS_FS_HAS_MANAGED_CACHE
> 	inode = erofs_init_managed_cache(sb);
>         if (IS_ERR(inode))
> 		return PTR_ERR(inode);
> 	sbi->managed_cache = inode;
> #endif
> etc.  Matter of taste, but IME if destructor parallels the cleanups on failure
> exits in constructor it often makes sense to make use of that and kill the
> duplication...  Anyway, that's a separate store; sbi->dev_name is a lot more
> obvious one.


I guess if I don't misunderstand, that is another suggestion -- in
short, leave all destructors to .kill_sb() and
cleanup fill_super(). I think it makes sense as well, though the reason
why the initial erofs code was is that
I just refer other filesystems such as ext4 and f2fs which handle
failure in fill_super() constructor as well.
Anyway, your suggestion is a good idea (it's more cleaner), I will play
with it.

I will kill dev_name in patch v3 at least, and try to clean up all
failure exits as you mentioned.

Thanks for your suggestions... Let me resend v3 later :)

Thanks,
Gao Xiang


>
>
> diff --git a/drivers/staging/erofs/internal.h b/drivers/staging/erofs/internal.h
> index 382258fc124d..16bab07e69d8 100644
> --- a/drivers/staging/erofs/internal.h
> +++ b/drivers/staging/erofs/internal.h
> @@ -117,8 +117,6 @@ struct erofs_sb_info {
>  	u8 volume_name[16];             /* volume name */
>  	u32 requirements;
>  
> -	char *dev_name;
> -
>  	unsigned int mount_opt;
>  	unsigned int shrinker_run_no;
>  
> diff --git a/drivers/staging/erofs/super.c b/drivers/staging/erofs/super.c
> index cadbcc11702a..a6ee69d0ce45 100644
> --- a/drivers/staging/erofs/super.c
> +++ b/drivers/staging/erofs/super.c
> @@ -367,15 +367,14 @@ static struct inode *erofs_init_managed_cache(struct super_block *sb)
>  
>  #endif
>  
> -static int erofs_read_super(struct super_block *sb,
> -			    const char *dev_name,
> +static int erofs_fill_super(struct super_block *sb,
>  			    void *data, int silent)
>  {
>  	struct inode *inode;
>  	struct erofs_sb_info *sbi;
>  	int err = -EINVAL;
>  
> -	infoln("read_super, device -> %s", dev_name);
> +	infoln("read_super, device -> %s", sb->s_id);
>  	infoln("options -> %s", (char *)data);
>  
>  	if (unlikely(!sb_set_blocksize(sb, EROFS_BLKSIZ))) {
> @@ -453,20 +452,10 @@ static int erofs_read_super(struct super_block *sb,
>  		goto err_iget;
>  	}
>  
> -	/* save the device name to sbi */
> -	sbi->dev_name = __getname();
> -	if (!sbi->dev_name) {
> -		err = -ENOMEM;
> -		goto err_devname;
> -	}
> -
> -	snprintf(sbi->dev_name, PATH_MAX, "%s", dev_name);
> -	sbi->dev_name[PATH_MAX - 1] = '\0';
> -
>  	erofs_register_super(sb);
>  
>  	if (!silent)
> -		infoln("mounted on %s with opts: %s.", dev_name,
> +		infoln("mounted on %s with opts: %s.", sb->s_id,
>  		       (char *)data);
>  	return 0;
>  	/*
> @@ -474,9 +463,6 @@ static int erofs_read_super(struct super_block *sb,
>  	 * the following name convention, thus new features
>  	 * can be integrated easily without renaming labels.
>  	 */
> -err_devname:
> -	dput(sb->s_root);
> -	sb->s_root = NULL;
>  err_iget:
>  #ifdef EROFS_FS_HAS_MANAGED_CACHE
>  	iput(sbi->managed_cache);
> @@ -504,8 +490,7 @@ static void erofs_put_super(struct super_block *sb)
>  
>  	WARN_ON(sb->s_magic != EROFS_SUPER_MAGIC);
>  
> -	infoln("unmounted for %s", sbi->dev_name);
> -	__putname(sbi->dev_name);
> +	infoln("unmounted for %s", sb->s_id);
>  
>  #ifdef EROFS_FS_HAS_MANAGED_CACHE
>  	iput(sbi->managed_cache);
> @@ -525,33 +510,12 @@ static void erofs_put_super(struct super_block *sb)
>  	sb->s_fs_info = NULL;
>  }
>  
> -
> -struct erofs_mount_private {
> -	const char *dev_name;
> -	char *options;
> -};
> -
> -/* support mount_bdev() with options */
> -static int erofs_fill_super(struct super_block *sb,
> -			    void *_priv, int silent)
> -{
> -	struct erofs_mount_private *priv = _priv;
> -
> -	return erofs_read_super(sb, priv->dev_name,
> -		priv->options, silent);
> -}
> -
>  static struct dentry *erofs_mount(
>  	struct file_system_type *fs_type, int flags,
>  	const char *dev_name, void *data)
>  {
> -	struct erofs_mount_private priv = {
> -		.dev_name = dev_name,
> -		.options = data
> -	};
> -
>  	return mount_bdev(fs_type, flags, dev_name,
> -		&priv, erofs_fill_super);
> +		data, erofs_fill_super);
>  }
>  
>  static void erofs_kill_sb(struct super_block *sb)
