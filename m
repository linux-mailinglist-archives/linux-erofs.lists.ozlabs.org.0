Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B3687A765A
	for <lists+linux-erofs@lfdr.de>; Wed, 20 Sep 2023 10:51:09 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lists.ozlabs.org;
	s=201707; t=1695199867;
	bh=aOrmEQVHlGP4NIc/KsyybAf3h59NYTPKZ1pCQKmMgow=;
	h=Subject:To:Date:In-Reply-To:References:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:Cc:
	 From;
	b=WG2OIWP41mEAPdEF8HaX1rX2d8Rwgg0LylkHERBfOAsgIl1aWE8THurTfxtHJ8gTy
	 5wLNNvP02H7meUfMctpaW2/SsPLoEkB1dwqK53aEnD4dlujeMzn5oZEcxOO50KeXJg
	 ZYjHUXrvCCvB2CHfni4NGY3NDW0HfTAC0kDP4P6Od1Crp6ItswTVcsBm5GeqkpOvdQ
	 eu0XeFTdSdVgMtD8iY8IP/77FoCvBU/RoMXrJn1icZV9C8T3khaubLem+neplHy8Mt
	 +6j7UqXPFsRIY/zoS51p9UjQTrCi4bZRhexAJU756aKlbVr00082JbtuunNvdVBuaV
	 Y4GPt9iUczDmA==
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4RrC1R0yhKz3cC3
	for <lists+linux-erofs@lfdr.de>; Wed, 20 Sep 2023 18:51:07 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=linuxfromscratch.org header.i=@linuxfromscratch.org header.a=rsa-sha256 header.s=cert4 header.b=eObk1KcH;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linuxfromscratch.org (client-ip=208.118.68.85; helo=rivendell.linuxfromscratch.org; envelope-from=xry111@linuxfromscratch.org; receiver=lists.ozlabs.org)
Received: from rivendell.linuxfromscratch.org (rivendell.linuxfromscratch.org [208.118.68.85])
	by lists.ozlabs.org (Postfix) with ESMTP id 4RrC1K1Tm3z3c5T
	for <linux-erofs@lists.ozlabs.org>; Wed, 20 Sep 2023 18:51:00 +1000 (AEST)
Received: from [192.168.3.211] (unknown [36.44.137.238])
	by rivendell.linuxfromscratch.org (Postfix) with ESMTPSA id 1EF0B1C1DCD;
	Wed, 20 Sep 2023 08:50:31 +0000 (GMT)
X-Virus-Status: Clean
X-Virus-Scanned: clamav-milter 1.0.0 at rivendell.linuxfromscratch.org
Message-ID: <34d45270efccc44b64af835e73c1d1e111ce5098.camel@linuxfromscratch.org>
Subject: Re: [PATCH v7 12/13] ext4: switch to multigrain timestamps
To: Christian Brauner <brauner@kernel.org>, Jeff Layton <jlayton@kernel.org>
Date: Wed, 20 Sep 2023 16:50:26 +0800
In-Reply-To: <20230920-leerung-krokodil-52ec6cb44707@brauner>
References: <20230807-mgctime-v7-0-d1dec143a704@kernel.org>
	 <20230919110457.7fnmzo4nqsi43yqq@quack3>
	 <1f29102c09c60661758c5376018eac43f774c462.camel@kernel.org>
	 <4511209.uG2h0Jr0uP@nimes>
	 <08b5c6fd3b08b87fa564bb562d89381dd4e05b6a.camel@kernel.org>
	 <20230920-leerung-krokodil-52ec6cb44707@brauner>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.0 
MIME-Version: 1.0
X-Spam-Status: No, score=-3.0 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
	RCVD_IN_ZEN_BLOCKED_OPENDNS,RDNS_NONE,SPF_FAIL,URIBL_BLOCKED,
	URIBL_DBL_BLOCKED_OPENDNS,URIBL_ZEN_BLOCKED_OPENDNS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	rivendell.linuxfromscratch.org
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
From: Xi Ruoyao via Linux-erofs <linux-erofs@lists.ozlabs.org>
Reply-To: Xi Ruoyao <xry111@linuxfromscratch.org>
Cc: Latchesar Ionkov <lucho@ionkov.net>, Martin Brandenburg <martin@omnibond.com>, Konstantin Komarov <almaz.alexandrovich@paragon-software.com>, Jan Kara <jack@suse.cz>, linux-xfs@vger.kernel.org, "Darrick
 J. Wong" <djwong@kernel.org>, Dominique Martinet <asmadeus@codewreck.org>, Christian Schoenebeck <linux_oss@crudebyte.com>, linux-unionfs@vger.kernel.org, David Howells <dhowells@redhat.com>, Chris Mason <clm@fb.com>, Andreas Dilger <adilger.kernel@dilger.ca>, Marc Dionne <marc.dionne@auristor.com>, codalist@coda.cs.cmu.edu, linux-afs@lists.infradead.org, linux-mtd@lists.infradead.org, Mike Marshall <hubcap@omnibond.com>, Paulo Alcantara <pc@manguebit.com>, Amir Goldstein <l@gmail.com>, Eric Van Hensbergen <ericvh@kernel.org>, bug-gnulib@gnu.org, Andreas Gruenbacher <agruenba@redhat.com>, Miklos Szeredi <miklos@szeredi.hu>, Richard Weinberger <richard@nod.at>, Mark Fasheh <mark@fasheh.com>, Hugh Dickins <hughd@google.com>, Benjamin Coddington <bcodding@redhat.com>, Tyler Hicks <code@tyhicks.com>, cluster-devel@redhat.com, coda@cs.cmu.edu, linux-mm@kvack.org, Ilya Dryomov <idryomov@gmail.com>, Iurii Zaikin <yzaikin@google.com>, Namjae Jeon <linkinjeon@kernel.org>, Trond Myklebust <tr
 ond.myklebust@hammerspace.com>, Shyam Prasad N <sprasad@microsoft.com>, ecryptfs@vger.kernel.org, Kees Cook <keescook@chromium.org>, ocfs2-devel@lists.linux.dev, linux-cifs@vger.kernel.org, linux-erofs@lists.ozlabs.org, Josef Bacik <josef@toxicpanda.com>, Tom Talpey <tom@talpey.com>, Tejun Heo <tj@kernel.org>, Yue Hu <huyue2@coolpad.com>, David Sterba <dsterba@suse.com>, Alexander Viro <viro@zeniv.linux.org.uk>, Ronnie Sahlberg <ronniesahlberg@gmail.com>, Jaegeuk Kim <jaegeuk@kernel.org>, ceph-devel@vger.kernel.org, Xiubo Li <xiubli@redhat.com>, OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>, Jan Harkes <jaharkes@cs.cmu.edu>, linux-nfs@vger.kernel.org, linux-ext4@vger.kernel.org, Theodore Ts'o <tytso@mit.edu>, Joseph Qi <joseph.qi@linux.alibaba.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, v9fs@lists.linux.dev, ntfs3@lists.linux.dev, samba-technical@lists.samba.org, linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net, Steve French <sfrench@samba.org>, Sergey 
 Senozhatsky <senozhatsky@chromium.org>, Luis Chamberlain <mcgrof@kernel.org>, Hans de Goede <hdegoede@redhat.com>, devel@lists.orangefs.org, Anna Schumaker <anna@kernel.org>, Jan Kara <jack@suse.com>, Bo b Peterson <rpeterso@redhat.com>, linux-fsdevel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, Sungjong Seo <sj1557.seo@samsung.com>, Bruno Haible <bruno@clisp.org>, linux-btrfs@vger.kernel.org, Joel Becker <jlbec@evilplan.org>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On Wed, 2023-09-20 at 10:41 +0200, Christian Brauner wrote:
> > > f1 was last written to *after* f2 was last written to. If the timesta=
mp of f1
> > > is then lower than the timestamp of f2, timestamps are fundamentally =
broken.
> > >=20
> > > Many things in user-space depend on timestamps, such as build system
> > > centered around 'make', but also 'find ... -newer ...'.
> > >=20
> >=20
> >=20
> > What does breakage with make look like in this situation? The "fuzz"
> > here is going to be on the order of a jiffy. The typical case for make
> > timestamp comparisons is comparing source files vs. a build target. If
> > those are being written nearly simultaneously, then that could be an
> > issue, but is that a typical behavior? It seems like it would be hard t=
o
> > rely on that anyway, esp. given filesystems like NFS that can do lazy
> > writeback.
> >=20
> > One of the operating principles with this series is that timestamps can
> > be of varying granularity between different files. Note that Linux
> > already violates this assumption when you're working across filesystems
> > of different types.
> >=20
> > As to potential fixes if this is a real problem:
> >=20
> > I don't really want to put this behind a mount or mkfs option (a'la
> > relatime, etc.), but that is one possibility.
> >=20
> > I wonder if it would be feasible to just advance the coarse-grained
> > current_time whenever we end up updating a ctime with a fine-grained
> > timestamp? It might produce some inode write amplification. Files that
>=20
> Less than ideal imho.
>=20
> If this risks breaking existing workloads by enabling it unconditionally
> and there isn't a clear way to detect and handle these situations
> without risk of regression then we should move this behind a mount
> option.
>=20
> So how about the following:
>=20
> From cb14add421967f6e374eb77c36cc4a0526b10d17 Mon Sep 17 00:00:00 2001
> From: Christian Brauner <brauner@kernel.org>
> Date: Wed, 20 Sep 2023 10:00:08 +0200
> Subject: [PATCH] vfs: move multi-grain timestamps behind a mount option
>=20
> While we initially thought we can do this unconditionally it turns out
> that this might break existing workloads that rely on timestamps in very
> specific ways and we always knew this was a possibility. Move
> multi-grain timestamps behind a vfs mount option.

I agree with this solution.

You can add some metainfo:

Reported-by: Ken Moffat <ken@linuxfromscratch.org>
Bisected-by: Xi Ruoyao <xry111@linuxfromscratch.org>
Link: https://lists.linuxfromscratch.org/sympa/arc/lfs-dev/2023-09/msg00036=
.html

> Signed-off-by: Christian Brauner <brauner@kernel.org>
> ---
> =C2=A0fs/fs_context.c=C2=A0=C2=A0=C2=A0=C2=A0 | 18 ++++++++++++++++++
> =C2=A0fs/inode.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=
=C2=A0 4 ++--
> =C2=A0fs/proc_namespace.c |=C2=A0 1 +
> =C2=A0fs/stat.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 |=C2=A0 2 +-
> =C2=A0include/linux/fs.h=C2=A0 |=C2=A0 4 +++-
> =C2=A05 files changed, 25 insertions(+), 4 deletions(-)
>=20
> diff --git a/fs/fs_context.c b/fs/fs_context.c
> index a0ad7a0c4680..dd4dade0bb9e 100644
> --- a/fs/fs_context.c
> +++ b/fs/fs_context.c
> @@ -44,6 +44,7 @@ static const struct constant_table common_set_sb_flag[]=
 =3D {
> =C2=A0	{ "mand",	SB_MANDLOCK },
> =C2=A0	{ "ro",		SB_RDONLY },
> =C2=A0	{ "sync",	SB_SYNCHRONOUS },
> +	{ "mgtime",	SB_MGTIME },
> =C2=A0	{ },
> =C2=A0};
> =C2=A0
> @@ -52,18 +53,32 @@ static const struct constant_table common_clear_sb_fl=
ag[] =3D {
> =C2=A0	{ "nolazytime",	SB_LAZYTIME },
> =C2=A0	{ "nomand",	SB_MANDLOCK },
> =C2=A0	{ "rw",		SB_RDONLY },
> +	{ "nomgtime",	SB_MGTIME },
> =C2=A0	{ },
> =C2=A0};
> =C2=A0
> +static inline int check_mgtime(unsigned int token, const struct fs_conte=
xt *fc)
> +{
> +	if (token !=3D SB_MGTIME)
> +		return 0;
> +	if (!(fc->fs_type->fs_flags & FS_MGTIME))
> +		return invalf(fc, "Filesystem doesn't support multi-grain timestamps")=
;
> +	return 0;
> +}
> +
> =C2=A0/*
> =C2=A0 * Check for a common mount option that manipulates s_flags.
> =C2=A0 */
> =C2=A0static int vfs_parse_sb_flag(struct fs_context *fc, const char *key=
)
> =C2=A0{
> =C2=A0	unsigned int token;
> +	int ret;
> =C2=A0
> =C2=A0	token =3D lookup_constant(common_set_sb_flag, key, 0);
> =C2=A0	if (token) {
> +		ret =3D check_mgtime(token, fc);
> +		if (ret)
> +			return ret;
> =C2=A0		fc->sb_flags |=3D token;
> =C2=A0		fc->sb_flags_mask |=3D token;
> =C2=A0		return 0;
> @@ -71,6 +86,9 @@ static int vfs_parse_sb_flag(struct fs_context *fc, con=
st char *key)
> =C2=A0
> =C2=A0	token =3D lookup_constant(common_clear_sb_flag, key, 0);
> =C2=A0	if (token) {
> +		ret =3D check_mgtime(token, fc);
> +		if (ret)
> +			return ret;
> =C2=A0		fc->sb_flags &=3D ~token;
> =C2=A0		fc->sb_flags_mask |=3D token;
> =C2=A0		return 0;
> diff --git a/fs/inode.c b/fs/inode.c
> index 54237f4242ff..fd1a2390aaa3 100644
> --- a/fs/inode.c
> +++ b/fs/inode.c
> @@ -2141,7 +2141,7 @@ EXPORT_SYMBOL(current_mgtime);
> =C2=A0
> =C2=A0static struct timespec64 current_ctime(struct inode *inode)
> =C2=A0{
> -	if (is_mgtime(inode))
> +	if (IS_MGTIME(inode))
> =C2=A0		return current_mgtime(inode);
> =C2=A0	return current_time(inode);
> =C2=A0}
> @@ -2588,7 +2588,7 @@ struct timespec64 inode_set_ctime_current(struct in=
ode *inode)
> =C2=A0		now =3D current_time(inode);
> =C2=A0
> =C2=A0		/* Just copy it into place if it's not multigrain */
> -		if (!is_mgtime(inode)) {
> +		if (!IS_MGTIME(inode)) {
> =C2=A0			inode_set_ctime_to_ts(inode, now);
> =C2=A0			return now;
> =C2=A0		}
> diff --git a/fs/proc_namespace.c b/fs/proc_namespace.c
> index 250eb5bf7b52..08f5bf4d2c6c 100644
> --- a/fs/proc_namespace.c
> +++ b/fs/proc_namespace.c
> @@ -49,6 +49,7 @@ static int show_sb_opts(struct seq_file *m, struct supe=
r_block *sb)
> =C2=A0		{ SB_DIRSYNC, ",dirsync" },
> =C2=A0		{ SB_MANDLOCK, ",mand" },
> =C2=A0		{ SB_LAZYTIME, ",lazytime" },
> +		{ SB_MGTIME, ",mgtime" },
> =C2=A0		{ 0, NULL }
> =C2=A0	};
> =C2=A0	const struct proc_fs_opts *fs_infop;
> diff --git a/fs/stat.c b/fs/stat.c
> index 6e60389d6a15..2f18dd5de18b 100644
> --- a/fs/stat.c
> +++ b/fs/stat.c
> @@ -90,7 +90,7 @@ void generic_fillattr(struct mnt_idmap *idmap, u32 requ=
est_mask,
> =C2=A0	stat->size =3D i_size_read(inode);
> =C2=A0	stat->atime =3D inode->i_atime;
> =C2=A0
> -	if (is_mgtime(inode)) {
> +	if (IS_MGTIME(inode)) {
> =C2=A0		fill_mg_cmtime(stat, request_mask, inode);
> =C2=A0	} else {
> =C2=A0		stat->mtime =3D inode->i_mtime;
> diff --git a/include/linux/fs.h b/include/linux/fs.h
> index 4aeb3fa11927..03e415fb3a7c 100644
> --- a/include/linux/fs.h
> +++ b/include/linux/fs.h
> @@ -1114,6 +1114,7 @@ extern int send_sigurg(struct fown_struct *fown);
> =C2=A0#define SB_NODEV=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 BIT(2)	/=
* Disallow access to device special files */
> =C2=A0#define SB_NOEXEC=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 BIT(3)	/* Dis=
allow program execution */
> =C2=A0#define SB_SYNCHRONOUS=C2=A0 BIT(4)	/* Writes are synced at once */
> +#define SB_MGTIME	BIT(5)	/* Use multi-grain timestamps */
> =C2=A0#define SB_MANDLOCK=C2=A0=C2=A0=C2=A0=C2=A0 BIT(6)	/* Allow mandato=
ry locks on an FS */
> =C2=A0#define SB_DIRSYNC=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 BIT(7)	/* Director=
y modifications are synchronous */
> =C2=A0#define SB_NOATIME=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 BIT(10)	/* Do not =
update access times. */
> @@ -2105,6 +2106,7 @@ static inline bool sb_rdonly(const struct super_blo=
ck *sb) { return sb->s_flags
> =C2=A0					((inode)->i_flags & (S_SYNC|S_DIRSYNC)))
> =C2=A0#define IS_MANDLOCK(inode)	__IS_FLG(inode, SB_MANDLOCK)
> =C2=A0#define IS_NOATIME(inode)	__IS_FLG(inode, SB_RDONLY|SB_NOATIME)
> +#define IS_MGTIME(inode)	__IS_FLG(inode, SB_MGTIME)
> =C2=A0#define IS_I_VERSION(inode)	__IS_FLG(inode, SB_I_VERSION)
> =C2=A0
> =C2=A0#define IS_NOQUOTA(inode)	((inode)->i_flags & S_NOQUOTA)
> @@ -2366,7 +2368,7 @@ struct file_system_type {
> =C2=A0 */
> =C2=A0static inline bool is_mgtime(const struct inode *inode)
> =C2=A0{
> -	return inode->i_sb->s_type->fs_flags & FS_MGTIME;
> +	return inode->i_sb->s_flags & SB_MGTIME;
> =C2=A0}
> =C2=A0
> =C2=A0extern struct dentry *mount_bdev(struct file_system_type *fs_type,

