Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 58FB077559C
	for <lists+linux-erofs@lfdr.de>; Wed,  9 Aug 2023 10:41:21 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4RLNnW1Wnqz304l
	for <lists+linux-erofs@lfdr.de>; Wed,  9 Aug 2023 18:41:19 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=parknet.co.jp (client-ip=210.171.160.6; helo=mail.parknet.co.jp; envelope-from=hirofumi@parknet.co.jp; receiver=lists.ozlabs.org)
X-Greylist: delayed 192 seconds by postgrey-1.37 at boromir; Wed, 09 Aug 2023 18:41:12 AEST
Received: from mail.parknet.co.jp (mail.parknet.co.jp [210.171.160.6])
	by lists.ozlabs.org (Postfix) with ESMTP id 4RLNnN74s1z2yVb
	for <linux-erofs@lists.ozlabs.org>; Wed,  9 Aug 2023 18:41:12 +1000 (AEST)
Received: from ibmpc.myhome.or.jp (server.parknet.ne.jp [210.171.168.39])
	by mail.parknet.co.jp (Postfix) with ESMTPSA id 2BF732055FA1;
	Wed,  9 Aug 2023 17:41:12 +0900 (JST)
Received: from devron.myhome.or.jp (foobar@devron.myhome.or.jp [192.168.0.3])
	by ibmpc.myhome.or.jp (8.17.2/8.17.2/Debian-1) with ESMTPS id 3798fAMk208573
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 9 Aug 2023 17:41:11 +0900
Received: from devron.myhome.or.jp (foobar@localhost [127.0.0.1])
	by devron.myhome.or.jp (8.17.2/8.17.2/Debian-1) with ESMTPS id 3798fAiA140744
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 9 Aug 2023 17:41:10 +0900
Received: (from hirofumi@localhost)
	by devron.myhome.or.jp (8.17.2/8.17.2/Submit) id 3798f9uW140743;
	Wed, 9 Aug 2023 17:41:09 +0900
From: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
To: Jeff Layton <jlayton@kernel.org>
Subject: Re: [PATCH v7 05/13] fat: make fat_update_time get its own timestamp
In-Reply-To: <87msz08vc7.fsf@mail.parknet.co.jp> (OGAWA Hirofumi's message of
	"Wed, 09 Aug 2023 17:37:44 +0900")
References: <20230807-mgctime-v7-0-d1dec143a704@kernel.org>
	<20230807-mgctime-v7-5-d1dec143a704@kernel.org>
	<87msz08vc7.fsf@mail.parknet.co.jp>
Date: Wed, 09 Aug 2023 17:41:09 +0900
Message-ID: <87il9o8v6i.fsf@mail.parknet.co.jp>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
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
Cc: Latchesar Ionkov <lucho@ionkov.net>, Martin Brandenburg <martin@omnibond.com>, Konstantin Komarov <almaz.alexandrovich@paragon-software.com>, "Darrick J. Wong" <djwong@kernel.org>, Dominique Martinet <asmadeus@codewreck.org>, Christian Schoenebeck <linux_oss@crudebyte.com>, ecryptfs@vger.kernel.org, Yue Hu <huyue2@gl0jj8bn.sched.sma.tdnsstic1.cn>, David Howells <dhowells@redhat.com>, Chris Mason <clm@fb.com>, Andreas Dilger <adilger.kernel@dilger.ca>, Hans de Goede <hdegoede@redhat.com>, Marc Dionne <marc.dionne@auristor.com>, linux-xfs@vger.kernel.org, linux-afs@lists.infradead.org, linux-mtd@lists.infradead.org, Mike Marshall <hubcap@omnibond.com>, Paulo Alcantara <pc@manguebit.com>, linux-cifs@vger.kernel.org, Eric Van Hensbergen <ericvh@kernel.org>, Andreas Gruenbacher <agruenba@redhat.com>, Miklos Szeredi <miklos@szeredi.hu>, Richard Weinberger <richard@nod.at>, Mark Fasheh <mark@fasheh.com>, linux-unionfs@vger.kernel.org, Hugh Dickins <hughd@google.com>, Benjamin Coddington
  <bcodding@redhat.com>, Tyler Hicks <code@tyhicks.com>, cluster-devel@redhat.com, coda@cs.cmu.edu, linux-mm@kvack.org, Ilya Dryomov <idryomov@gmail.com>, Iurii Zaikin <yzaikin@google.com>, Namjae Jeon <linkinjeon@kernel.org>, Trond Myklebust <trond.myklebust@hammerspace.com>, codalist@telemann.coda.cs.cmu.edu, Shyam Prasad N <sprasad@microsoft.com>, Amir Goldstein <amir73il@gmail.com>, Kees Cook <keescook@chromium.org>, ocfs2-devel@lists.linux.dev, Josef Bacik <josef@toxicpanda.com>, Tom Talpey <tom@talpey.com>, Tejun Heo <tj@kernel.org>, Alexander Viro <viro@zeniv.linux.org.uk>, Ronnie Sahlberg <ronniesahlberg@gmail.com>, David Sterba <dsterba@suse.com>, Jaegeuk Kim <jaegeuk@kernel.org>, ceph-devel@vger.kernel.org, Xiubo Li <xiubli@redhat.com>, Jan Harkes <jaharkes@cs.cmu.edu>, Christian Brauner <brauner@kernel.org>, linux-ext4@vger.kernel.org, Theodore Ts'o <tytso@mit.edu>, Joseph Qi <joseph.qi@linux.alibaba.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, v9fs@lists.linux.d
 ev, ntfs3@lists.linux.dev, samba-technical@lists.samba.org, linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net, Steve French <sfrench@samba.org>, Sergey Senozhatsky <senozhatsky@chromium.org>, Luis Chamberlain <mcgrof@kernel.org>, devel@lists.orangefs.org, Anna Schumaker <anna@kernel.org>, Jan Kara <jack@suse.com>, Bob Peterson <rpeterso@redhat.com>, linux-fsdevel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, Sungjong Seo <sj1557.seo@samsung.com>, linux-erofs@lists.ozlabs.org, linux-nfs@vger.kernel.org, linux-btrfs@vger.kernel.org, Joel Becker <jlbec@evilplan.org>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

OGAWA Hirofumi <hirofumi@mail.parknet.co.jp> writes:

> Jeff Layton <jlayton@kernel.org> writes:
>
>> Also, it may be that things have changed by the time we get to calling
>> fat_update_time after checking inode_needs_update_time. Ensure that we
>> attempt the i_version bump if any of the S_* flags besides S_ATIME are
>> set.
>
> I'm not sure what it meaning though, this is from
> generic_update_time(). Are you going to change generic_update_time()
> too? If so, it doesn't break lazytime feature?
>
> Thanks.

BTW, fat is not implementing lazytime now, but it is for future.
-- 
OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
